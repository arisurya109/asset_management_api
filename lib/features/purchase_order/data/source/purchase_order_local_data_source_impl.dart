// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/purchase_order/data/model/purchase_order_detail_model.dart';
import 'package:asset_management_api/features/purchase_order/data/model/purchase_order_model.dart';
import 'package:asset_management_api/features/purchase_order/data/source/purchase_order_local_data_source.dart';

class PurchaseOrderLocalDataSourceImpl implements PurchaseOrderLocalDataSource {
  PurchaseOrderLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<PurchaseOrderModel> createPurchaseOrder(
    PurchaseOrderModel params,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final checkPoNumber = await txn.query(
          'SELECT COUNT(id) FROM t_purchase_orders WHERE purchase_order_number = ?',
          [params.purchaseOrderNumber],
        );

        if (checkPoNumber.first.fields['COUNT(id)'] as int > 0) {
          throw CreateException(
            message:
                'Failed to create purchase order, po number already exists',
          );
        }

        final newPurchaseOrder = await txn.query('''
          INSERT INTO t_purchase_orders
            (purchase_order_number, vendor_id, created_by, remarks, status)
          VALUES
            (?, ?, ?, ?, ?)
          ''', [
          params.purchaseOrderNumber,
          params.vendorId,
          params.createdById,
          params.remarks,
          params.status,
        ]);

        if (newPurchaseOrder.insertId == null) {
          throw CreateException(message: 'Failed, please try again');
        } else {
          await txn.queryMulti(
            '''
            INSERT INTO t_purchase_order_details
              (purchase_order_id, asset_model_id, quantity)
            VALUES
              (?, ?, ?)
            ''',
            params.items!
                .map((e) => [newPurchaseOrder.insertId, e.modelId, e.quantity]),
          );

          final checkItems = await txn.query(
            'SELECT * FROM t_purchase_order_details WHERE purchase_order_id = ?',
            [newPurchaseOrder.insertId],
          );

          if (checkItems.firstOrNull == null) {
            throw CreateException(message: 'Failed add items');
          }

          final responsePurchaseOrder = await txn.query(
            '''
            SELECT 
	            po.id AS id,
	            po.purchase_order_number AS purchase_order_number,
	            v.name AS vendor,
	            po.status AS status,
	            u.name AS created_by,
	            po.created_at AS created_at,
	            po.remarks AS remarks
            FROM 
            	t_purchase_orders AS po
            LEFT JOIN t_vendors AS v ON po.vendor_id = v.id
            LEFT JOIN t_users AS u ON po.created_by = u.id
            WHERE po.id = ?
            ''',
            [newPurchaseOrder.insertId],
          );

          final purchaserOrderMap = responsePurchaseOrder.first.fields;

          final responsePurchaseOrdeDetail = await txn.query(
            '''
            SELECT
            	po.purchase_order_number AS po_number,
            	ast.name AS types,
            	asb.name AS brand,
            	ac.name AS category,
            	am.name AS model,
            	pod.quantity AS quantity
            FROM
            	t_purchase_order_details AS pod
            LEFT JOIN t_purchase_orders AS po ON pod.purchase_order_id = po.id
            LEFT JOIN t_asset_models AS am ON pod.asset_model_id = am.id
            LEFT JOIN t_asset_types AS ast ON am.type_id = ast.id
            LEFT JOIN t_asset_brands AS asb ON am.brand_id = asb.id
            LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
            WHERE pod.purchase_order_id = ?
            ''',
            [newPurchaseOrder.insertId],
          );

          final responsePoDetail =
              responsePurchaseOrdeDetail.map((e) => e.fields).toList();

          purchaserOrderMap
              .addEntries({'items': responsePoDetail}.entries.toList());

          return purchaserOrderMap;
        }
      });

      return PurchaseOrderModel.fromMap(response!);
    } catch (e) {
      throw CreateException(message: e.toString());
    }
  }

  @override
  Future<List<PurchaseOrderModel>> findAllPurchaseOrder() async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
        SELECT 
	        po.id AS id,
	        po.purchase_order_number AS purchase_order_number,
	        v.name AS vendor,
	        po.status AS status,
	        u.name AS created_by,
	        po.created_at AS created_at,
	        po.remarks AS remarks
        FROM 
        	t_purchase_orders AS po
        LEFT JOIN t_vendors AS v ON po.vendor_id = v.id
        LEFT JOIN t_users AS u ON po.created_by = u.id
        ''',
      );

      if (response.firstOrNull == null) {
        throw CreateException(message: 'Purchase order is empty');
      }

      return response.map((e) => PurchaseOrderModel.fromMap(e.fields)).toList();
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<PurchaseOrderModel> updatePurchaseOrder(PurchaseOrderModel params) {
    // TODO: implement updatePurchaseOrder
    throw UnimplementedError();
  }

  @override
  Future<List<PurchaseOrderDetailModel>> findPurchaserOrderDetailItem(
    int purchaseOrderId,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
        SELECT
        	po.purchase_order_number AS po_number,
        	ast.name AS types,
        	asb.name AS brand,
        	ac.name AS category,
        	am.name AS model,
        	pod.quantity AS quantity
        FROM
        	t_purchase_order_details AS pod
        LEFT JOIN t_purchase_orders AS po ON pod.purchase_order_id = po.id
        LEFT JOIN t_asset_models AS am ON pod.asset_model_id = am.id
        LEFT JOIN t_asset_types AS ast ON am.type_id = ast.id
        LEFT JOIN t_asset_brands AS asb ON am.brand_id = asb.id
        LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
        WHERE pod.purchase_order_id = ?
        ''',
        [purchaseOrderId],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Po number not found items');
      }

      return response
          .map((e) => PurchaseOrderDetailModel.fromDatabase(e.fields))
          .toList();
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }
}
