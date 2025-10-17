// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/helpers/asset.dart';
import 'package:asset_management_api/features/assets/data/model/assets_request_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_response_model.dart';
import 'package:asset_management_api/features/assets/data/source/assets_local_data_source.dart';

class AssetsLocalDataSourceImpl implements AssetsLocalDataSource {
  AssetsLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<List<AssetsResponseModel>> findAllAssets() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
	      a.id AS id,
	      a.serial_number AS serial_number,
	      a.asset_code AS asset_code,
	      a.status AS status,
	      a.conditions AS conditions,
	      a.quantity AS quantity,
	      am.unit AS uom,
	      am.name AS model,
	      ac.name AS category,
	      ab.name AS brand,
	      ats.name AS types,
	      c.name AS color,
	      l1.name AS location,
	      a.purchase_order_number AS purchase_order,
	      a.remarks AS remarks
      FROM
      	t_assets AS a
      LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
      LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
      LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
      LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
      LEFT JOIN t_colors AS c ON a.color_id  = c.id
      LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(message: 'Assets is empty');
    }

    return response.map((e) => AssetsResponseModel.fromMap(e.fields)).toList();
  }

  @override
  Future<AssetsResponseModel> createAssets(AssetsRequestModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      // Serial Number Not Null or Not Empty

      if (params.serialNumber!.isNotEmpty && params.uom == 1) {
        final checkSerialNumber = await txn.query(
          'SELECT COUNT(id) FROM t_assets WHERE serial_number = ?',
          [params.serialNumber],
        );

        if (checkSerialNumber.first.fields['COUNT(id)'] == 0) {
          final templateCode = AssetHelper.templateCode;

          final response = await txn.query(
            'SELECT COUNT(id) FROM t_assets WHERE DATE(registred_at) = CURDATE()',
          );

          const width = 4;

          final count = response.first.fields['COUNT(id)'] as int;
          final lastCode = (count + 1).toString().padLeft(width, '0');

          final initTypeCategory = await txn.query(
            '''
            SELECT 
              ac.init AS category_init,
              at.init AS type_init
            FROM t_asset_models AS am
            LEFT JOIN t_asset_categories AS ac ON am.category_id  = ac.id
            LEFT JOIN t_asset_types AS at ON am.type_id  = at.id
            WHERE am.id = ?
            ''',
            [params.assetModelId],
          );

          final categoryInit = initTypeCategory.first.fields['category_init'];
          final typeInit = initTypeCategory.first.fields['type_init'];

          final assetCode = '$typeInit-$categoryInit-$templateCode$lastCode';

          final registredAsset = await txn.query(
            '''
            INSERT INTO t_assets (
              asset_code, 
              serial_number, 
              status, 
              conditions, 
              remarks, 
              registred_by, 
              asset_model_id, 
              color_id, 
              purchase_order_number, 
              quantity, 
              location_id)
            VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
            [
              assetCode,
              params.serialNumber,
              params.status,
              params.conditions,
              params.remarks,
              params.registredBy,
              params.assetModelId,
              params.colorId,
              params.purchaseOrderNumber,
              1,
              params.locationId,
            ],
          );

          if (registredAsset.insertId == null || registredAsset.insertId == 0) {
            throw CreateException(message: 'Failed to create asset code');
          } else {
            final newAsset = await txn.query(
              '''
              SELECT
	              a.id AS id,
	              a.serial_number AS serial_number,
	              a.asset_code AS asset_code,
	              a.status AS status,
	              a.conditions AS conditions,
	              a.quantity AS quantity,
	              am.unit AS uom,
	              am.name AS model,
	              ac.name AS category,
	              ab.name AS brand,
	              ats.name AS types,
	              c.name AS color,
	              l1.name AS location,
	              a.purchase_order_number AS purchase_order,
	              a.remarks AS remarks
              FROM
              	t_assets AS a
              LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
              LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
              LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
              LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
              LEFT JOIN t_colors AS c ON a.color_id  = c.id
              LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
                WHERE a.id = ?
            ''',
              [registredAsset.insertId],
            );
            return newAsset.first.fields;
          }
        } else {
          throw CreateException(
            message: 'Failed to create asset, serial number already to exists',
          );
        }
      } else if (params.uom == 1) {
        final templateCode = AssetHelper.templateCode;

        final response = await txn.query(
          'SELECT COUNT(id) FROM t_assets WHERE DATE(registred_at) = CURDATE()',
        );
        const width = 4;

        final count = response.first.fields['COUNT(id)'] as int;
        final lastCode = (count + 1).toString().padLeft(width, '0');

        final initTypeCategory = await txn.query(
          '''
            SELECT 
              ac.init AS category_init,
              at.init AS type_init
            FROM t_asset_models AS am
            LEFT JOIN t_asset_categories AS ac ON am.category_id  = ac.id
            LEFT JOIN t_asset_types AS at ON am.type_id  = at.id
            WHERE am.id = ?
            ''',
          [params.assetModelId],
        );

        final categoryInit = initTypeCategory.first.fields['category_init'];
        final typeInit = initTypeCategory.first.fields['type_init'];

        final assetCode = '$typeInit-$categoryInit-$templateCode$lastCode';

        final registredAsset = await txn.query(
          '''
            INSERT INTO t_assets (
              asset_code, 
              status, 
              conditions, 
              remarks, 
              registred_by, 
              asset_model_id, 
              color_id, 
              purchase_order_number, 
              quantity, 
              location_id)
            VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
          [
            assetCode,
            params.status,
            params.conditions,
            params.remarks,
            params.registredBy,
            params.assetModelId,
            params.colorId,
            params.purchaseOrderNumber,
            1,
            params.locationId,
          ],
        );

        if (registredAsset.insertId == null || registredAsset.insertId == 0) {
          throw CreateException(message: 'Failed to create asset code');
        } else {
          final newAsset = await txn.query(
            '''
            SELECT
	            a.id AS id,
	            a.serial_number AS serial_number,
	            a.asset_code AS asset_code,
	            a.status AS status,
	            a.conditions AS conditions,
	            a.quantity AS quantity,
	            am.unit AS uom,
	            am.name AS model,
	            ac.name AS category,
	            ab.name AS brand,
	            ats.name AS types,
	            c.name AS color,
	            l1.name AS location,
	            a.purchase_order_number AS purchase_order,
	            a.remarks AS remarks
            FROM
              t_assets AS a
            LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
            LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
            LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
            LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
            LEFT JOIN t_colors AS c ON a.color_id  = c.id
            LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
            WHERE a.id = ?
            ''',
            [registredAsset.insertId],
          );
          return newAsset.first.fields;
        }
      } else {
        // Asset Consumable
        final checkAssetLocation = await txn.query(
          'SELECT id FROM t_assets WHERE asset_model_id = ? AND location_id = ?',
          [params.assetModelId, params.locationId],
        );

        int idAsset;

        if (checkAssetLocation.firstOrNull == null) {
          // Insert
          final newAsset = await txn.query(
            '''
          INSERT INTO t_assets
            (asset_model_id, quantity, location_id, registred_by)
          VALUES
            (?, ?, ?, ?)
          ''',
            [
              params.assetModelId,
              params.quantity,
              params.locationId,
              params.registredBy,
            ],
          );
          idAsset = newAsset.insertId!;
        } else {
          // Update Quantity
          idAsset = checkAssetLocation.first.fields['id'] as int;
          final response = await txn.query(
            '''
          UPDATE t_assets
          SET quantity = quantity + ?
          WHERE id = ?
          ''',
            [params.quantity, idAsset],
          );

          if (response.affectedRows == 0) {
            throw CreateException(message: 'Failed to update quantity asset');
          }
        }

        final newAsset = await txn.query(
          '''
              SELECT
	              a.id AS id,
	              a.serial_number AS serial_number,
	              a.asset_code AS asset_code,
	              a.status AS status,
	              a.conditions AS conditions,
	              a.quantity AS quantity,
	              am.unit AS uom,
	              am.name AS model,
	              ac.name AS category,
	              ab.name AS brand,
	              ats.name AS types,
	              c.name AS color,
	              l1.name AS location,
	              a.purchase_order_number AS purchase_order,
	              a.remarks AS remarks
              FROM
              	t_assets AS a
              LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
              LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
              LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
              LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
              LEFT JOIN t_colors AS c ON a.color_id  = c.id
              LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
                WHERE a.id = ?
            ''',
          [idAsset],
        );
        return newAsset.first.fields;
      }
    });

    return AssetsResponseModel.fromMap(response!);
  }
}
