import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/picking/data/model/picking_detail_item_model.dart';
import 'package:asset_management_api/features/picking/data/model/picking_detail_response_model.dart';
import 'package:asset_management_api/features/picking/data/model/picking_header_model.dart';
import 'package:asset_management_api/features/picking/data/source/picking_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class PickingLocalDataSourceImpl implements PickingLocalDataSource {
  PickingLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<List<PickingHeaderModel>> findAllPickingTask({
    required int userId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
        SELECT
          p.id AS id,
          p.preparation_code AS code,
          p.preparation_type AS type,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.status AS status,
          p.temporary_location_id AS temporary_location_id,
          l1.name AS temporary_location,
          p.notes AS notes,
          p.total_box AS total_box,
          (SELECT COUNT(*) 
           FROM t_preparation_details AS pd 
           WHERE pd.preparation_id = p.id) AS total_items,
          (SELECT SUM(pd.quantity) 
           FROM t_preparation_details AS pd 
           WHERE pd.preparation_id = p.id) AS total_quantity
        FROM
            t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_locations AS l1 ON p.temporary_location_id = l1.id
        WHERE p.worker_id = ?
          AND (p.status = 'ASSIGNED' OR p.status = 'PICKING')
        ORDER BY p.id ASC
        ''',
        [userId],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'There is no task to picking assets');
      }

      return response
          .map((e) => PickingHeaderModel.fromDatabase(e.fields))
          .toList();
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
  Future<PickingDetailResponseModel> findPickingDetail({
    required int id,
    required int userId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final rPickingHeader = await txn.query(
          '''
          SELECT
            p.id AS id,
            p.preparation_code AS code,
            p.preparation_type AS type,
            p.destination_id AS destination_id,
            l.name AS destination,
            p.status AS status,
            p.temporary_location_id AS temporary_location_id,
            l1.name AS temporary_location,
            p.notes AS notes,
            p.total_box AS total_box,
            (SELECT COUNT(*) 
             FROM t_preparation_details AS pd 
             WHERE pd.preparation_id = p.id) AS total_items,
            (SELECT SUM(pd.quantity) 
             FROM t_preparation_details AS pd 
             WHERE pd.preparation_id = p.id) AS total_quantity
          FROM
            t_preparations AS p
          LEFT JOIN t_locations AS l ON p.destination_id = l.id
          LEFT JOIN t_locations AS l1 ON p.temporary_location_id = l1.id
          WHERE 
            p.worker_id = ? AND
            p.status = 'PICKING' AND
            p.id = ?
          ORDER BY p.id ASC
          LIMIT 1
          ''',
          [userId, id],
        );

        if (rPickingHeader.firstOrNull == null) {
          throw NotFoundException(
            message: 'An error occurred, no task picking found',
          );
        }

        final pickingHeader = rPickingHeader.first.fields;

        final rPickingDetails = await txn.query(
          '''
          SELECT
          	pd.id AS id,
          	pd.asset_model_id AS model_id,
          	pd.quantity AS quantity,
          	am.is_consumable AS is_consumable,
          	am.name AS model,
          	at.name AS types,
          	ac.name AS category
          FROM 
          	t_preparation_details AS pd
          LEFT JOIN t_asset_models AS am ON pd.asset_model_id = am.id
          LEFT JOIN t_asset_types AS at ON am.type_id = at.id
          LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
          WHERE pd.preparation_id = ?
          ''',
          [id],
        );

        final pickingDetails = rPickingDetails.map((e) => e.fields).toList();

        for (final pickingDetail in pickingDetails) {
          final resPickItems = await db.query(
            '''
            SELECT
            	pdi.id AS id,
            	pdi.asset_id AS asset_id,
            	pdi.quantity AS quantity,
            	pdi.status AS status,
            	ast.asset_code AS asset_code,
            	ast.serial_number AS serial_number,
            	ast.location_id AS location_id,
            	l.name AS location
            FROM
            	t_preparation_detail_items AS pdi
            LEFT JOIN t_assets AS ast ON pdi.asset_id = ast.id
            LEFT JOIN t_locations AS l ON ast.location_id = l.id
            WHERE pdi.preparation_detail_id = ?
            ''',
            [pickingDetail['id']],
          );

          pickingDetail.addAll(
            {'allocated_items': resPickItems.map((e) => e.fields).toList()},
          );
        }

        pickingHeader.addAll({'items': pickingDetails});

        return pickingHeader;
      });

      return PickingDetailResponseModel.fromMap(response!);
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
  Future<String> pickedAsset({
    required int userId,
    required PickingDetailItemModel params,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final checkUserValid = await txn.query(
          '''
          SELECT 
          	p.worker_id AS worker_id
          FROM
          	t_preparation_detail_items AS pdi
          LEFT JOIN t_preparation_details AS pd ON pdi.preparation_detail_id = pd.id
          LEFT JOIN t_preparations AS p ON pd.preparation_id = p.id
          WHERE pdi.id = ?
          ''',
          [params.id],
        );

        final workerId = checkUserValid.first.fields['worker_id'] as int;

        if (userId != workerId) {
          throw UpdateException(
            message: 'An error has occurred, you are not the assigned worker',
          );
        }

        final prepItems = await txn.query(
          '''
          SELECT 
          	pdi.*,
          	ast.location_id AS location_id
          FROM  t_preparation_detail_items AS pdi
          LEFT JOIN t_assets AS ast ON pdi.asset_id = ast.id
          WHERE pdi.id = ?
          LIMIT 1
          ''',
          [params.id],
        );

        final items = prepItems.first.fields;

        if (items['status'] == 'PICKED') {
          throw UpdateException(message: 'The asset has been taken');
        } else if (items['location_id'] != params.locationId) {
          throw UpdateException(message: 'Invalid asset location');
        } else if (items['asset_id'] != params.assetId) {
          throw UpdateException(message: 'Assets not as requested');
        } else if (items['quantity'] != params.quantity) {
          throw UpdateException(
            message: 'The quantity does not match what was requested.',
          );
        } else {
          final updatedItems = await txn.query(
            '''
            UPDATE t_preparation_detail_items
            SET status = 'PICKED', scanned_at = CURRENT_TIMESTAMP
            WHERE id = ?
            ''',
            [params.id],
          );

          if (updatedItems.affectedRows == null) {
            throw UpdateException(
              message: 'An error has occurred, please try again',
            );
          } else {
            return 'Successfully picked asset';
          }
        }
      });

      return response!;
    } on UpdateException {
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
