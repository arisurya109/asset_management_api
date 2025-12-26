// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/helpers/asset.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class PreparationLocalDataSourceImpl implements PreparationLocalDataSource {
  PreparationLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<PreparationModel> createPreparation(PreparationModel params) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final templateCode = AssetHelper.templateCode;

        final response = await txn.query(
          '''
            SELECT COUNT(id) FROM t_preparations
            WHERE DATE(created_at) = CURDATE()
            ''',
        );

        const width = 4;

        final count = response.first.fields['COUNT(id)'] as int;
        final lastCode = (count + 1).toString().padLeft(width, '0');

        final assetCode = 'AP-$templateCode$lastCode';

        final newPreparation = await txn.query(
          '''
          INSERT INTO t_preparations
            (code, types, 
            destination_id, created_id, 
            worker_id, approved_id, 
            notes)
          VALUES
            (?, ?, ?, ?, ?, ?, ?, ?)
          ''',
          [
            assetCode,
            params.type,
            params.destinationId,
            params.createdId,
            params.workerId,
            params.approvedId,
            params.notes,
          ],
        );

        if (newPreparation.insertId == null || newPreparation.insertId == 0) {
          throw CreateException(
            message: 'Failed to create preparation, please try again',
          );
        } else {
          final responsePreparation = await txn.query(
            '''
            SELECT
            	t.id AS id,
            	t.code AS code,
            	t.types AS type, 
            	t.status AS status,
            	t.destination_id AS destination_id,
            	l1.name AS destination,
            	t.created_id AS created_id,
            	u1.name AS created_by,
            	t.worker_id AS worker_id,
            	u2.name AS worker_by,
            	t.approved_id AS approved_id,
            	u3.name AS approved_by,
            	t.location_id AS location_id,
            	l2.name AS location,
            	t.total_box AS total_box,
            	t.notes AS notes,
            	t.created_at AS created_at
            FROM
            	t_preparations AS t
            LEFT JOIN t_locations AS l1 ON t.destination_id = l1.id
            LEFT JOIN t_users AS u1 ON t.created_id = u1.id
            LEFT JOIN t_users AS u2 ON t.worker_id = u2.id
            LEFT JOIN t_users AS u3 ON t.approved_id = u3.id
            LEFT JOIN t_locations AS l2 ON t.location_id = l2.id
            WHERE t.id = ?
            ''',
            [newPreparation.insertId],
          );

          await txn.query(
            '''
            INSERT t_preparation_logs
              (preparation_id, status_to, changed_by)
            VALUES
              (?, ?, ?)
            ''',
            [newPreparation.insertId, 'DRAFT', params.createdId],
          );

          return responsePreparation.first.fields;
        }
      });
      return PreparationModel.fromDatabase(response!);
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
  Future<List<PreparationModel>> findAllPreparation() async {
    try {
      final db = await _database.connection;

      final responsePreparation = await db.query(
        '''
        SELECT
        	t.id AS id,
        	t.code AS code,
        	t.types AS type, 
        	t.status AS status,
        	t.destination_id AS destination_id,
        	l1.name AS destination,
        	t.created_id AS created_id,
        	u1.name AS created_by,
        	t.worker_id AS worker_id,
        	u2.name AS worker_by,
        	t.approved_id AS approved_id,
        	u3.name AS approved_by,
        	t.location_id AS location_id,
        	l2.name AS location,
        	t.total_box AS total_box,
        	t.notes AS notes,
        	t.created_at AS created_at
        FROM
        	t_preparations AS t
        LEFT JOIN t_locations AS l1 ON t.destination_id = l1.id
        LEFT JOIN t_users AS u1 ON t.created_id = u1.id
        LEFT JOIN t_users AS u2 ON t.worker_id = u2.id
        LEFT JOIN t_users AS u3 ON t.approved_id = u3.id
        LEFT JOIN t_locations AS l2 ON t.location_id = l2.id
        ''',
      );

      if (responsePreparation.firstOrNull == null ||
          responsePreparation.isEmpty) {
        throw NotFoundException(message: 'Preparation is empty');
      }

      return responsePreparation
          .map((e) => PreparationModel.fromDatabase(e.fields))
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
  Future<PreparationModel> findPreparationById(int params) async {
    try {
      final db = await _database.connection;

      final responsePreparation = await db.query(
        '''
        SELECT
        	t.id AS id,
        	t.code AS code,
        	t.types AS type, 
        	t.status AS status,
        	t.destination_id AS destination_id,
        	l1.name AS destination,
        	t.created_id AS created_id,
        	u1.name AS created_by,
        	t.worker_id AS worker_id,
        	u2.name AS worker_by,
        	t.approved_id AS approved_id,
        	u3.name AS approved_by,
        	t.location_id AS location_id,
        	l2.name AS location,
        	t.total_box AS total_box,
        	t.notes AS notes,
        	t.created_at AS created_at
        FROM
        	t_preparations AS t
        LEFT JOIN t_locations AS l1 ON t.destination_id = l1.id
        LEFT JOIN t_users AS u1 ON t.created_id = u1.id
        LEFT JOIN t_users AS u2 ON t.worker_id = u2.id
        LEFT JOIN t_users AS u3 ON t.approved_id = u3.id
        LEFT JOIN t_locations AS l2 ON t.location_id = l2.id
        WHERE t.id = ?
        ''',
        [params],
      );

      if (responsePreparation.firstOrNull == null ||
          responsePreparation.isEmpty) {
        throw NotFoundException(message: 'Preparation not found');
      }

      return PreparationModel.fromDatabase(responsePreparation.first.fields);
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
  Future<List<PreparationModel>> findPreparationByCodeOrDestination({
    required String params,
  }) async {
    try {
      final db = await _database.connection;

      final searchPattern = '%$params%';

      final responsePreparation = await db.query(
        '''
        SELECT
        	t.id AS id,
        	t.code AS code,
        	t.types AS type, 
        	t.status AS status,
        	t.destination_id AS destination_id,
        	l1.name AS destination,
        	t.created_id AS created_id,
        	u1.name AS created_by,
        	t.worker_id AS worker_id,
        	u2.name AS worker_by,
        	t.approved_id AS approved_id,
        	u3.name AS approved_by,
        	t.location_id AS location_id,
        	l2.name AS location,
        	t.total_box AS total_box,
        	t.notes AS notes,
        	t.created_at AS created_at
        FROM
        	t_preparations AS t
        LEFT JOIN t_locations AS l1 ON t.destination_id = l1.id
        LEFT JOIN t_users AS u1 ON t.created_id = u1.id
        LEFT JOIN t_users AS u2 ON t.worker_id = u2.id
        LEFT JOIN t_users AS u3 ON t.approved_id = u3.id
        LEFT JOIN t_locations AS l2 ON t.location_id = l2.id
        WHERE 
          t.code LIKE ? OR l1.name LIKE ?
        ORDER BY t.created_at DESC
        ''',
        [searchPattern, searchPattern],
      );

      if (responsePreparation.firstOrNull == null ||
          responsePreparation.isEmpty) {
        throw NotFoundException(message: 'Preparation not found');
      }

      return responsePreparation
          .map((e) => PreparationModel.fromDatabase(e.fields))
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
  Future<PreparationModel> updateStatusPreparation({
    required int id,
    required String status,
    required int userId,
    int? totalBox,
    int? locationId,
    String? remarks,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final preparationOld = await txn.query(
          'SELECT code, status FROM t_preparations WHERE id = ?',
          [id],
        );

        final oldStatus = preparationOld.first.fields['status'];
        final code = preparationOld.first.fields['code'];

        final response = await txn.query(
          '''
          UPDATE t_preparations
          SET status = ?, total_box = COALESCE(?, total_box), location_id = COALESCE(?, location_id)
          WHERE id = ?
          ''',
          [status, totalBox, locationId, id],
        );

        if (response.affectedRows == null || response.affectedRows == 0) {
          txn.rollback();
          throw UpdateException(message: 'Failed $status $code');
        }

        final insertLogs = await txn.query(
          '''
          INSERT INTO t_preparation_logs
            (preparation_id, status_from, status_to, changed_by, remarks)
          VALUES
            (?, ?, ?, ?, ?)
          ''',
          [id, oldStatus, status, userId, remarks],
        );

        if (insertLogs.affectedRows == null || insertLogs.affectedRows == 0) {
          txn.rollback();
          throw UpdateException(message: 'Failed $status $code');
        }

        final responsePreparation = await txn.query(
          '''
          SELECT
          	t.id AS id,
          	t.code AS code,
          	t.types AS type, 
          	t.status AS status,
          	t.destination_id AS destination_id,
          	l1.name AS destination,
          	t.created_id AS created_id,
          	u1.name AS created_by,
          	t.worker_id AS worker_id,
          	u2.name AS worker_by,
          	t.approved_id AS approved_id,
          	u3.name AS approved_by,
          	t.location_id AS location_id,
          	l2.name AS location,
          	t.total_box AS total_box,
          	t.notes AS notes,
          	t.created_at AS created_at
          FROM
          	t_preparations AS t
          LEFT JOIN t_locations AS l1 ON t.destination_id = l1.id
          LEFT JOIN t_users AS u1 ON t.created_id = u1.id
          LEFT JOIN t_users AS u2 ON t.worker_id = u2.id
          LEFT JOIN t_users AS u3 ON t.approved_id = u3.id
          LEFT JOIN t_locations AS l2 ON t.location_id = l2.id
          WHERE t.id = ?
          ''',
          [id],
        );

        return responsePreparation.first.fields;
      });

      return PreparationModel.fromDatabase(response!);
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
