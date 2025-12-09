// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/preparation_item/data/model/preparation_item_model.dart';
import 'package:asset_management_api/features/preparation_item/data/source/preparation_item_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class PreparationItemLocalDataSourceImpl
    implements PreparationItemLocalDataSource {
  PreparationItemLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<PreparationItemModel> createPreparationItem({
    required PreparationItemModel params,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        // Get Asset Model Id dan Quantity yang ready
        final responseQuantityStorage = await txn.query(
          '''
          SELECT
	          a.id AS id,
	          a.asset_model_id AS asset_model_id,
          	am.unit AS unit,
          	a.quantity AS quantity,
          	a.is_picked AS is_picked
          FROM
          	t_assets AS a
          LEFT JOIN t_asset_models AS am ON a.asset_model_id = am.id
          WHERE a.id = ? AND a.location_id = ?
          ''',
          [params.assetId, params.locationId],
        );

        if (responseQuantityStorage.firstOrNull == null) {
          throw NotFoundException(
            message: 'Failed, asset is invalid.',
          );
        }

        final stockInStorage =
            responseQuantityStorage.first.fields['quantity'] as int;

        final assetModelId =
            responseQuantityStorage.first.fields['asset_model_id'] as int;

        final unit = responseQuantityStorage.first.fields['unit'] as int;
        final isPicked =
            responseQuantityStorage.first.fields['is_picked'] as int;

        final assetId = responseQuantityStorage.first.fields['id'] as int;

        if (unit == 1 && isPicked == 1) {
          throw CreateException(message: 'Asset already pick');
        }

        if (params.quantity! > stockInStorage) {
          throw CreateException(message: 'Quantity exceeds stock on the rack');
        }

        // Check apakah asset yang di scan sesuai dengan permintaan
        final responsePreparationDetail = await txn.query(
          '''
          SELECT * FROM t_preparation_details 
          WHERE asset_model_id = ? AND preparation_id = ? AND id = ?
          ''',
          [assetModelId, params.preparationId, params.preparationDetailId],
        );

        if (responsePreparationDetail.firstOrNull == null) {
          throw NotFoundException(
            message: 'Failed, The selected asset is invalid',
          );
        }

        final preparationDetailMap = responsePreparationDetail.first.fields;

        final qtyTarget = preparationDetailMap['quantity_target'] as int;
        final qtyPicked = preparationDetailMap['quantity_picked'] as int;

        if (qtyPicked >= qtyTarget) {
          throw Exception('Quantity already completed');
        }

        // Insert Preparation Detail Item
        final prepItem = await txn.query('''
          INSERT INTO t_preparation_detail_items
            (preparation_detail_id, asset_id, picked_by, quantity, location_id)
          VALUES
            (?, ?, ?, ?, ?)
          ''', [
          params.preparationDetailId,
          params.assetId,
          params.pickedById,
          params.quantity,
          params.locationId,
        ]);

        if (prepItem.insertId == null) {
          throw CreateException(message: 'Failed to insert assets');
        }

        if (unit == 1) {
          await txn.query(
            '''
            UPDATE t_assets
            SET is_picked = 1
            WHERE id = ?
            ''',
            [assetId],
          );
        }

        // Jika quantity Picked 0, update status IN_PROGRESS
        if (qtyPicked == 0) {
          await txn.query(
            '''
            UPDATE t_preparation_details
            SET quantity_picked = quantity_picked + 1, status = 'PROGRESS'
            WHERE id = ?
            ''',
            [params.preparationDetailId],
          );
          // Jika Quantity Target sudah terpenuhi maka update status READY
        } else if ((qtyPicked + params.quantity!) == qtyTarget) {
          await txn.query(
            '''
            UPDATE t_preparation_details
            SET quantity_picked = quantity_picked + 1, status = 'COMPLETED'
            WHERE id = ?
            ''',
            [params.preparationDetailId],
          );
        } else {
          // Increment Quantity Picked
          await txn.query(
            '''
            UPDATE t_preparation_details
            SET quantity_picked = quantity_picked + 1
            WHERE id = ?
            ''',
            [params.preparationDetailId],
          );
        }
        // Get hasil preparation Item
        final responsePrepItem = await txn.query(
          '''
          SELECT
            pi.id AS id,
            pi.preparation_detail_id AS preparation_detail_id,
            pd.preparation_id AS preparation_id,
            pi.asset_id AS asset_id,
            a.asset_model_id AS asset_model_id,
            a.asset_code AS asset_code,
            m.name AS asset_model,
            t.name AS asset_type,
            b.name AS asset_brand,
            c.name AS asset_category,
            pi.picked_by AS picked_by_id,
            u.name AS picked_by,
            pi.quantity AS quantity,
            pi.location_id AS location_id,
            l.name AS location,
            a.purchase_order AS purchase_order,
            a.status AS status,
            a.conditions AS conditions
          FROM
            t_preparation_detail_items AS pi
          LEFT JOIN t_preparation_details AS pd ON pi.preparation_detail_id = pd.id
          LEFT JOIN t_assets AS a ON pi.asset_id = a.id
          LEFT JOIN t_asset_models AS m ON a.asset_model_id = m.id
          LEFT JOIN t_asset_types AS t ON m.type_id = t.id
          LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
          LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
          LEFT JOIN t_users AS u ON pi.picked_by = u.id
          LEFT JOIN t_locations AS l ON pi.location_id = l.id
          WHERE pi.id = ?
          ''',
          [prepItem.insertId],
        );

        return responsePrepItem.first.fields;
      });

      return PreparationItemModel.fromDatabase(response!);
    } on CreateException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<String> deletePreparationItem({
    required int id,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final checkPreparationItem = await txn.query(
          '''
          SELECT * FROM t_preparation_detail_items 
          WHERE id = ?
          ''',
          [id],
        );

        if (checkPreparationItem.firstOrNull == null ||
            checkPreparationItem.isEmpty) {
          throw DeleteException(message: 'Failed, assets not found');
        }

        final responseAsset = await txn.query(
          '''
          SELECT 
          	a.asset_model_id AS asset_model_id,
          	am.unit AS unit,
          	a.is_picked AS is_picked
          FROM
          	t_assets AS a
          LEFT JOIN t_asset_models AS am ON a.asset_model_id = am.id
          WHERE a.id = ?
          ''',
          [checkPreparationItem.first.fields['asset_id']],
        );

        if (responseAsset.first.fields['unit'] as int == 1 &&
            responseAsset.first.fields['is_picked'] as int == 1) {
          await txn.query(
            '''
            UPDATE t_assets
            SET is_picked = 0
            WHERE id = ?
            ''',
            [checkPreparationItem.first.fields['asset_id']],
          );
        }

        final result = await txn.query(
          '''
          DELETE FROM
            t_preparation_detail_items
          WHERE id = ?
          ''',
          [id],
        );

        if (result.affectedRows == null || result.affectedRows == 0) {
          throw DeleteException(message: 'Failed, please try again');
        }

        return 'Successfully deleted preparation item';
      });
      return response!;
    } on DeleteException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<PreparationItemModel>>
      findAllPreparationItemByPreparationDetailId({
    required int preparationDetailId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
          SELECT
            pi.id AS id,
            pi.preparation_detail_id AS preparation_detail_id,
            pd.preparation_id AS preparation_id,
            pi.asset_id AS asset_id,
            a.asset_model_id AS asset_model_id,
            a.asset_code AS asset_code,
            m.name AS asset_model,
            t.name AS asset_type,
            b.name AS asset_brand,
            c.name AS asset_category,
            pi.picked_by AS picked_by_id,
            u.name AS picked_by,
            pi.quantity AS quantity,
            pi.location_id AS location_id,
            l.name AS location,
            a.purchase_order AS purchase_order,
            a.status AS status,
            a.conditions AS conditions
          FROM
            t_preparation_detail_items AS pi
          LEFT JOIN t_preparation_details AS pd ON pi.preparation_detail_id = pd.id
          LEFT JOIN t_assets AS a ON pi.asset_id = a.id
          LEFT JOIN t_asset_models AS m ON a.asset_model_id = m.id
          LEFT JOIN t_asset_types AS t ON m.type_id = t.id
          LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
          LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
          LEFT JOIN t_users AS u ON pi.picked_by = u.id
          LEFT JOIN t_locations AS l ON pi.location_id = l.id
          WHERE pi.preparation_detail_id = ?
          ''',
        [preparationDetailId],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Assets is empty');
      } else {
        return response
            .map((e) => PreparationItemModel.fromDatabase(e.fields))
            .toList();
      }
    } on NotFoundException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<PreparationItemModel>> findAllPreparationItemByPreparationId({
    required int preparationId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
          SELECT
            pi.id AS id,
            pi.preparation_detail_id AS preparation_detail_id,
            pd.preparation_id AS preparation_id,
            pi.asset_id AS asset_id,
            a.asset_model_id AS asset_model_id,
            a.asset_code AS asset_code,
            m.name AS asset_model,
            t.name AS asset_type,
            b.name AS asset_brand,
            c.name AS asset_category,
            pi.picked_by AS picked_by_id,
            u.name AS picked_by,
            pi.quantity AS quantity,
            pi.location_id AS location_id,
            l.name AS location,
            a.purchase_order AS purchase_order,
             a.status AS status,
            a.conditions AS conditions
          FROM
            t_preparation_detail_items AS pi
          LEFT JOIN t_preparation_details AS pd ON pi.preparation_detail_id = pd.id
          LEFT JOIN t_assets AS a ON pi.asset_id = a.id
          LEFT JOIN t_asset_models AS m ON a.asset_model_id = m.id
          LEFT JOIN t_asset_types AS t ON m.type_id = t.id
          LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
          LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
          LEFT JOIN t_users AS u ON pi.picked_by = u.id
          LEFT JOIN t_locations AS l ON pi.location_id = l.id
          WHERE pd.preparation_id = ?
          ''',
        [preparationId],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Assets is empty');
      } else {
        return response
            .map((e) => PreparationItemModel.fromDatabase(e.fields))
            .toList();
      }
    } on NotFoundException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }
}
