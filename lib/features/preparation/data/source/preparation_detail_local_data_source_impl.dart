// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_detail_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_detail_response_model.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_detail_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class PreparationDetailLocalDataSourceImpl
    implements PreparationDetailLocalDataSource {
  PreparationDetailLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<String> addPreparationDetail({
    required PreparationDetailModel params,
    required int userId,
  }) async {
    if (params.isConsumable == 1) {
      return _addConsumable(params, userId);
    } else {
      return _addNonConsumable(params, userId);
    }
  }

  @override
  Future<PreparationDetailResponseModel> getPreparationDetails({
    required int preparationId,
  }) async {
    try {
      final db = await _database.connection;

      final resPreparation = await db.query(
        '''
        SELECT
          p.id AS id,
          p.preparation_code AS code,
          p.preparation_type AS type,
          p.status AS status,
          p.destination_id AS destination_id,
          d.name AS destination,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.created_id AS created_id,
          c.name AS created,
          p.worker_id AS worker_id,
          w.name AS worker,
          p.approved_id AS approved_id,
          a.name AS approved,
          p.total_box AS total_box,
          p.notes AS notes,
          p.created_at AS created_at
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS d ON p.destination_id = d.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_id = c.id
        LEFT JOIN t_users AS w ON p.worker_id = w.id
        LEFT JOIN t_users AS a ON p.approved_id = a.id
        WHERE p.id = ?
        LIMIT 1
        ''',
        [preparationId],
      );

      if (resPreparation.firstOrNull == null) {
        throw NotFoundException(
          message: 'An error occurred, preparation not found',
        );
      }

      final preparation = resPreparation.first.fields;

      final resPrepDetail = await db.query(
        '''
        SELECT
        	pd.id AS id,
        	pd.preparation_id AS preparation_id,
        	pd.asset_id AS asset_id,
        	pd.quantity AS quantity,
        	pd.status AS status,
        	ast.asset_code AS asset_code,
        	ast.location_id AS location_id,
        	ast.purchase_order AS purchase_order,
        	l.name AS location,
        	am.name AS model,
        	am.is_consumable AS is_consumable,
        	ac.name AS category
        FROM
        	t_preparation_details AS pd
        LEFT JOIN t_assets AS ast ON pd.asset_id = ast.id
        LEFT JOIN t_locations AS l ON ast.location_id = l.id
        LEFT JOIN t_asset_models AS am ON ast.asset_model_id = am.id
        LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
        WHERE pd.preparation_id =  ?
        ORDER BY l.name ASC
        ''',
        [preparation['id']],
      );

      final preparationDetails = resPrepDetail.map((e) => e.fields).toList();

      preparation.addAll({'items': preparationDetails});

      return PreparationDetailResponseModel.fromDatabase(preparation);
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

  Future<String> _addNonConsumable(
    PreparationDetailModel params,
    int userId,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final getPreparation = await txn.query(
          'SELECT * FROM t_preparations WHERE id = ? LIMIT 1',
          [params.preparationId],
        );

        final preparation = getPreparation.first.fields;

        if (preparation['created_id'] != userId) {
          throw CreateException(
            message: 'An error occurred, You do not have access',
          );
        }

        Results responseAsset;

        if (params.purchaseOrder == null) {
          responseAsset = await txn.query(
            '''
            SELECT
              ast.*, 
              l.name AS location_name
            FROM
              t_assets AS ast
            LEFT JOIN t_locations AS l ON ast.location_id = l.id
            WHERE
              ast.asset_model_id = ? AND
              ast.status = 'READY' AND
              ast.is_reserved = 0 AND
              (ast.purchase_order IS NULL OR ast.purchase_order = '') AND
              (l.location_type = 'RACK' OR l.location_type = 'BOX') AND
              l.is_storage = 1 AND
              (ast.conditions = 'NEW' OR ast.conditions = 'GOOD')
            ORDER BY
              ast.registred_at ASC
            LIMIT ?
            FOR UPDATE
            ''',
            [params.modelId, params.quantity],
          );
        } else {
          responseAsset = await txn.query(
            '''
            SELECT
              ast.*, 
              l.name AS location_name
            FROM
              t_assets AS ast
            LEFT JOIN t_locations AS l ON ast.location_id = l.id
            WHERE
              ast.asset_model_id = ? AND
              ast.status = 'READY' AND
              ast.is_reserved = 0 AND
              (l.location_type = 'RACK' OR l.location_type = 'BOX') AND
              l.is_storage = 1 AND
              ast.purchase_order = ? AND
              (ast.conditions = 'NEW' OR ast.conditions = 'GOOD')
            ORDER BY
              ast.registred_at ASC
            LIMIT ?
            FOR UPDATE
            ''',
            [params.modelId, params.purchaseOrder, params.quantity],
          );
        }

        if (responseAsset.isEmpty) {
          throw NotFoundException(message: 'Stock assets are unavailable');
        }

        for (final row in responseAsset) {
          final asset = row.fields;
          final assetId = asset['id'];

          await txn.query(
            'UPDATE t_assets SET is_reserved = 1 WHERE id = ?',
            [assetId],
          );

          await txn.query(
            '''
            INSERT INTO t_preparation_details
              (preparation_id, asset_id, quantity)
            VALUES
              (?, ?, 1)
            ''',
            [params.preparationId, assetId],
          );
        }

        String response;

        if (responseAsset.length == params.quantity) {
          response = 'Successfully added all assets';
        } else {
          response = 'Only ${responseAsset.length} assets available and added';
        }

        return response;
      });
      return response!;
    } on NotFoundException {
      rethrow;
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

  Future<String> _addConsumable(
    PreparationDetailModel params,
    int userId,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final getPreparation = await txn.query(
          'SELECT created_id FROM t_preparations WHERE id = ? LIMIT 1',
          [params.preparationId],
        );

        if (getPreparation.first['created_id'] != userId) {
          throw CreateException(
            message: 'An error occurred, You do not have access',
          );
        }

        final responseAsset = await txn.query(
          '''
        SELECT ast.id, ast.quantity, ast.quantity_reserved
        FROM t_assets AS ast
        LEFT JOIN t_locations AS l ON ast.location_id = l.id
        WHERE ast.asset_model_id = ? 
          AND (ast.quantity - ast.quantity_reserved) >= ?
          AND l.is_storage = 1
          AND (l.location_type = 'RACK' OR l.location_type = 'BOX')
        ORDER BY ast.registred_at ASC
        LIMIT 1
        FOR UPDATE
        ''',
          [params.modelId, params.quantity],
        );

        if (responseAsset.isEmpty) {
          throw NotFoundException(
            message: 'Insufficient stock at the same location',
          );
        }

        final asset = responseAsset.first.fields;
        final assetId = asset['id'] as int;
        final needed = params.quantity!;

        await txn.query(
          'UPDATE t_assets SET quantity_reserved = quantity_reserved + ? WHERE id = ?',
          [needed, assetId],
        );

        await txn.query(
          '''
        INSERT INTO t_preparation_details
          (preparation_id, asset_id, quantity)
        VALUES
          (?, ?, ?)
        ''',
          [params.preparationId, assetId, needed],
        );

        return 'Successfully added asset';
      });

      return response!;
    } on NotFoundException {
      rethrow;
    } on CreateException {
      rethrow;
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }
}
