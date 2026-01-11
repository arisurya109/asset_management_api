// ignore_for_file: unnecessary_await_in_return, public_member_api_docs, inference_failure_on_collection_literal

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/asset.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_pagination_model.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class PreparationLocalDataSourceImpl implements PreparationLocalDataSource {
  PreparationLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<PreparationModel> createPreparation({
    required PreparationModel params,
  }) async {
    if (params.type == 'INTERNAL') {
      return await _createPreparationInternal(params);
    } else {
      return await _createPreparationExternal(params);
    }
  }

  Future<PreparationModel> _createPreparationExternal(
    PreparationModel params,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final checkDestination = await txn.query(
          'SELECT * FROM t_locations WHERE id = ? AND is_active = 1 LIMIT 1',
          [params.destinationId],
        );

        if (checkDestination.firstOrNull == null) {
          throw NotFoundException(
            message: 'An error occurred, destination not found',
          );
        }

        final destinationMap = checkDestination.first.fields;

        if (destinationMap['is_storage'] == 1 ||
            destinationMap['location_type'] != 'VENDOR') {
          throw CreateException(
            message: 'An error occurred, destination cannot valid',
          );
        }

        final responseCurrentLastId = await txn.query(
          'SELECT COUNT(id) FROM t_preparations WHERE DATE(created_at) = CURDATE()',
        );

        final templateCode = AssetHelper.templateCode;

        const width = 4;

        final count = responseCurrentLastId.first.fields['COUNT(id)'] as int;

        final lastCode = (count + 1).toString().padLeft(width, '0');

        final preparationCode = 'AP-$templateCode$lastCode';

        final newPreparation = await txn.query('''
          INSERT INTO t_preparations
            (preparation_code, preparation_type, destination_id, created_id, worker_id, approved_id, notes)
          VALUES
            (?, ?, ?, ?, ?, ?, ?)
          ''', [
          preparationCode,
          'EXTERNAL',
          params.destinationId,
          params.createdId,
          params.workerId,
          params.approvedId,
          params.notes,
        ]);

        if (newPreparation.insertId == null) {
          throw CreateException(
            message:
                'An error occured, please try again create preparation document',
          );
        }

        await txn.query('''
          INSERT INTO t_preparation_logs
            (preparation_id, to_status, updated_by, notes)
          VALUES
            (?, ?, ?, ?)
          ''', [
          newPreparation.insertId,
          'DRAFT',
          params.createdId,
          'CREATE DOCUMENT',
        ]);

        final responsePrep = await txn.query(
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
          [newPreparation.insertId],
        );

        return responsePrep.first.fields;
      });

      return PreparationModel.fromJson(response!);
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

  Future<PreparationModel> _createPreparationInternal(
    PreparationModel params,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final checkDestination = await txn.query(
          'SELECT * FROM t_locations WHERE id = ? AND is_active = 1 LIMIT 1',
          [params.destinationId],
        );

        if (checkDestination.firstOrNull == null) {
          throw NotFoundException(
            message: 'An error occurred, destination not found',
          );
        }

        final destinationMap = checkDestination.first.fields;

        if (destinationMap['is_storage'] == 1 ||
            destinationMap['location_type'] == 'VENDOR') {
          throw CreateException(
            message: 'An error occurred, destination cannot valid',
          );
        }

        final responseCurrentLastId = await txn.query(
          'SELECT COUNT(id) FROM t_preparations WHERE DATE(created_at) = CURDATE()',
        );

        final templateCode = AssetHelper.templateCode;

        const width = 4;

        final count = responseCurrentLastId.first.fields['COUNT(id)'] as int;

        final lastCode = (count + 1).toString().padLeft(width, '0');

        final preparationCode = 'AP-$templateCode$lastCode';

        final newPreparation = await txn.query('''
          INSERT INTO t_preparations
            (preparation_code, preparation_type, destination_id, created_id, worker_id, approved_id, notes)
          VALUES
            (?, ?, ?, ?, ?, ?, ?)
          ''', [
          preparationCode,
          'INTERNAL',
          params.destinationId,
          params.createdId,
          params.workerId,
          params.approvedId,
          params.notes,
        ]);

        if (newPreparation.insertId == null) {
          throw CreateException(
            message:
                'An error occured, please try again create preparation document',
          );
        }

        await txn.query('''
          INSERT INTO t_preparation_logs
            (preparation_id, to_status, updated_by, notes)
          VALUES
            (?, ?, ?, ?)
          ''', [
          newPreparation.insertId,
          'DRAFT',
          params.createdId,
          'CREATE DOCUMENT',
        ]);

        final responsePrep = await txn.query(
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
          [newPreparation.insertId],
        );

        return responsePrep.first.fields;
      });

      return PreparationModel.fromJson(response!);
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

  @override
  Future<PreparationPaginationModel> findPreparationByPagination({
    required int page,
    required int limit,
    String? query,
  }) async {
    try {
      final db = await _database.connection;
      final offset = (page - 1) * limit;

      var whereClause = 'WHERE p.status NOT IN (?, ?)';
      final queryArgs = <dynamic>['COMPLETED', 'CANCELLED'];

      if (query.isFilled()) {
        final pattern = '%${query!.trim()}%';
        whereClause += ' AND (p.preparation_code LIKE ? OR d.name LIKE ?)';
        queryArgs.addAll([pattern, pattern]);
      }

      final totalResponse = await db.query(
        '''
      SELECT COUNT(*) AS total 
      FROM t_preparations AS p
      LEFT JOIN t_locations AS d ON p.destination_id = d.id
      $whereClause
      ''',
        queryArgs,
      );
      final totalData = totalResponse.first.fields['total'] as int? ?? 0;

      final dataArgs = [...queryArgs, limit, offset];
      final response = await db.query(
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
      $whereClause
      ORDER BY p.created_at ASC
      LIMIT ? OFFSET ?
      ''',
        dataArgs,
      );

      final data =
          response.isEmpty ? [] : response.map((e) => e.fields).toList();

      final result = {
        'total_data': totalData,
        'current_page': page,
        'last_page': totalData > 0 ? (totalData / limit).ceil() : 1,
        'limit': limit,
        'data': data,
      };

      return PreparationPaginationModel.fromDatabase(result);
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<String>> getPreparationTypes() async {
    return ['INTERNAL', 'EXTERNAL'];
  }

  @override
  Future<PreparationModel> updatePreparationStatus({
    required int id,
    required String params,
    required int userId,
    int? totalBox,
    int? temporaryLocationId,
  }) async {
    if (params == 'APPROVED') {
      return await _updateByApproved(id: id, params: params, userId: userId);
    } else if (params == 'PICKING' || params == 'WAITING CHECK') {
      return await _updateByWorker(
        id: id,
        params: params,
        userId: userId,
        temporaryLocationId: temporaryLocationId,
      );
    } else {
      return await _updateByCreated(
        id: id,
        params: params,
        userId: userId,
        totalBox: totalBox,
      );
    }
  }

  Future<PreparationModel> _updateByCreated({
    required int id,
    required String params,
    required int userId,
    int? totalBox,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final responseGetPreparation = await txn.query(
          'SELECT * FROM t_preparations WHERE id = ? LIMIT 1',
          [id],
        );

        if (responseGetPreparation.firstOrNull == null) {
          throw NotFoundException(
            message: 'An error occurred, not found preparation',
          );
        }

        final preparation = responseGetPreparation.first.fields;

        // Check update preparation
        if (preparation['created_id'] != userId) {
          throw UpdateException(
            message: 'An error occurred, you do not have access',
          );
        }

        Results responseUpdate;

        if (totalBox != null) {
          responseUpdate = await txn.query(
            '''
            UPDATE t_preparations
            SET status = ?, total_box = ?, updated_at = CURRENT_TIMESTAMP
            WHERE id = ? AND created_id = ?
            ''',
            [params, totalBox, id, userId],
          );
        } else {
          responseUpdate = await txn.query(
            '''
            UPDATE t_preparations
            SET status = ?, updated_at = CURRENT_TIMESTAMP
            WHERE id = ? AND created_id = ?
            ''',
            [params, id, userId],
          );
        }

        if (responseUpdate.affectedRows == null) {
          throw UpdateException(
            message: 'An error occurred, please try again',
          );
        }

        final preparationLogs = await txn.query(
          '''
            INSERT INTO t_preparation_logs
              (preparation_id, from_status, to_status, updated_by)
            VALUES
              (?, ?, ?, ?)
            ''',
          [id, preparation['status'], params, userId],
        );

        if (preparationLogs.insertId == null) {
          txn.rollback();
          throw UpdateException(
            message: 'An error occurred, please try again',
          );
        }

        final newPreparation = await txn.query(
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
          [id],
        );

        return newPreparation.first.fields;
      });

      return PreparationModel.fromJson(response!);
    } on NotFoundException {
      rethrow;
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

  Future<PreparationModel> _updateByWorker({
    required int id,
    required String params,
    required int userId,
    int? temporaryLocationId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final responseGetPreparation = await txn.query(
          'SELECT * FROM t_preparations WHERE id = ? LIMIT 1',
          [id],
        );

        if (responseGetPreparation.firstOrNull == null) {
          throw NotFoundException(
            message: 'An error occurred, not found picking tasks',
          );
        }

        final preparation = responseGetPreparation.first.fields;

        // Check update preparation
        if (preparation['worker_id'] != userId) {
          throw UpdateException(
            message: 'An error occurred, you do not have access',
          );
        }

        Results responseUpdate;

        if (temporaryLocationId != null) {
          responseUpdate = await txn.query(
            '''
            UPDATE t_preparations
            SET status = ?, temporary_location_id = ?, updated_at = CURRENT_TIMESTAMP
            WHERE id = ? AND worker_id = ?
            ''',
            [params, temporaryLocationId, id, userId],
          );
        } else {
          responseUpdate = await txn.query(
            '''
            UPDATE t_preparations
            SET status = ?, updated_at = CURRENT_TIMESTAMP
            WHERE id = ? AND worker_id = ?
            ''',
            [params, id, userId],
          );
        }

        if (responseUpdate.affectedRows == null) {
          throw UpdateException(
            message: 'An error occurred, please try again',
          );
        }

        final preparationLogs = await txn.query(
          '''
            INSERT INTO t_preparation_logs
              (preparation_id, from_status, to_status, updated_by)
            VALUES
              (?, ?, ?, ?)
            ''',
          [id, preparation['status'], params, userId],
        );

        if (preparationLogs.insertId == null) {
          txn.rollback();
          throw UpdateException(
            message: 'An error occurred, please try again',
          );
        }

        final newPreparation = await txn.query(
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
          [id],
        );

        return newPreparation.first.fields;
      });

      return PreparationModel.fromJson(response!);
    } on NotFoundException {
      rethrow;
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

  Future<PreparationModel> _updateByApproved({
    required int id,
    required String params,
    required int userId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final responseGetPreparation = await txn.query(
          'SELECT * FROM t_preparations WHERE id = ? LIMIT 1',
          [id],
        );

        if (responseGetPreparation.firstOrNull == null) {
          throw NotFoundException(
            message: 'An error occurred, not found approval',
          );
        }

        final preparation = responseGetPreparation.first.fields;

        // Check update preparation
        if (preparation['approved_id'] != userId) {
          throw UpdateException(
            message: 'An error occurred, you do not have access',
          );
        }

        Results responseUpdate;

        responseUpdate = await txn.query(
          '''
            UPDATE t_preparations
            SET status = ?, updated_at = CURRENT_TIMESTAMP
            WHERE id = ? AND approved_id = ?
            ''',
          [params, id, userId],
        );

        if (responseUpdate.affectedRows == null) {
          throw UpdateException(
            message: 'An error occurred, please try again',
          );
        }

        final preparationLogs = await txn.query(
          '''
            INSERT INTO t_preparation_logs
              (preparation_id, from_status, to_status, updated_by)
            VALUES
              (?, ?, ?, ?)
            ''',
          [id, preparation['status'], params, userId],
        );

        if (preparationLogs.insertId == null) {
          txn.rollback();
          throw UpdateException(
            message: 'An error occurred, please try again',
          );
        }

        final newPreparation = await txn.query(
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
          [id],
        );

        return newPreparation.first.fields;
      });

      return PreparationModel.fromJson(response!);
    } on NotFoundException {
      rethrow;
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
