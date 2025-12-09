// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/helpers/asset.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source.dart';
import 'package:mysql1/mysql1.dart';
import 'package:path/path.dart' as p;

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

        String afterShippedCondition;

        if (params.afterShipped == 'USE') {
          afterShippedCondition = 'OLD';
        } else {
          afterShippedCondition = 'BAD';
        }

        final count = response.first.fields['COUNT(id)'] as int;
        final lastCode = (count + 1).toString().padLeft(width, '0');

        final assetCode = 'AP-$templateCode$lastCode';

        final newPreparation = await txn.query(
          '''
          INSERT INTO t_preparations
            (preparation_code, destination_id, 
            assigned_id, notes, created_by, 
            approved_by, after_shipped_status, 
            after_shipped_condition)
          VALUES
            (?, ?, ?, ?, ?, ?, ?, ?)
          ''',
          [
            assetCode,
            params.destinationId,
            params.assignedId,
            params.notes,
            params.createdById,
            params.approvedById,
            params.afterShipped,
            afterShippedCondition,
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
                p.id AS id,
                p.preparation_code AS preparation_code,
                p.destination_id AS destination_id,
                l.name AS destination,
                p.assigned_id AS assigned_id,
                a.name AS assigned,
                p.temporary_location_id AS temporary_location_id,
                t.name AS temporary_location,
                p.total_box AS total_box,
                p.status AS status,
                p.notes AS notes,
                p.created_by AS created_by_id,
                c.name AS created_by,
                p.updated_by AS updated_by_id,
                u.name AS updated_by,
                p.approved_by AS approved_by_id,
                ap.name AS approved_by,
                p.after_shipped_status AS after_shipped_status
              FROM
                t_preparations AS p
              LEFT JOIN t_locations AS l ON p.destination_id = l.id
              LEFT JOIN t_users AS a ON p.assigned_id = a.id
              LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
              LEFT JOIN t_users AS c ON p.created_by = c.id
              LEFT JOIN t_users AS u ON p.updated_by = u.id
              LEFT JOIN t_users AS ap ON p.approved_by = ap.id
              WHERE p.id = ?
              ''',
            [newPreparation.insertId],
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
          p.id AS id,
          p.preparation_code AS preparation_code,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.assigned_id AS assigned_id,
          a.name AS assigned,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.total_box AS total_box,
          p.status AS status,
          p.notes AS notes,
          p.created_by AS created_by_id,
          c.name AS created_by,
          p.updated_by AS updated_by_id,
          u.name AS updated_by,
          p.approved_by AS approved_by_id,
          ap.name AS approved_by,
          p.after_shipped_status AS after_shipped_status
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_users AS a ON p.assigned_id = a.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_by = c.id
        LEFT JOIN t_users AS u ON p.updated_by = u.id
        LEFT JOIN t_users AS ap ON p.approved_by = ap.id
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
          p.id AS id,
          p.preparation_code AS preparation_code,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.assigned_id AS assigned_id,
          a.name AS assigned,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.total_box AS total_box,
          p.status AS status,
          p.notes AS notes,
          p.created_by AS created_by_id,
          c.name AS created_by,
          p.updated_by AS updated_by_id,
          u.name AS updated_by,
          p.approved_by AS approved_by_id,
          ap.name AS approved_by,
          p.after_shipped_status AS after_shipped_status
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_users AS a ON p.assigned_id = a.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_by = c.id
        LEFT JOIN t_users AS u ON p.updated_by = u.id
        LEFT JOIN t_users AS ap ON p.approved_by = ap.id
        WHERE p.id = ?
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
  Future<PreparationModel> updateStatusApprovedPreparation({
    required int id,
    required int userId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final responsePreparation = await txn.query(
          'SELECT * FROM t_preparations WHERE id = ? AND status = ?',
          [id, 'READY'],
        );

        if (responsePreparation.firstOrNull == null ||
            responsePreparation.isEmpty) {
          throw NotFoundException(message: 'Preparation not found');
        }

        final preparation = responsePreparation.first.fields;

        final approvedBy = preparation['approved_by'] as int;

        if (approvedBy != userId) {
          throw UpdateException(
            message: 'Failed, You do not have permission to approve',
          );
        }

        final response = await txn.query(
          '''
        UPDATE t_preparations
        SET status = ?, approved_at = NOW()
        WHERE id = ? AND approved_by = ?
        ''',
          ['APPROVED', id, userId],
        );

        if (response.affectedRows == null || response.affectedRows == 0) {
          throw UpdateException(
            message: 'Failed approve preparations, please try again',
          );
        }
        final responseNewPreparation = await db.query(
          '''
        SELECT
          p.id AS id,
          p.preparation_code AS preparation_code,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.assigned_id AS assigned_id,
          a.name AS assigned,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.total_box AS total_box,
          p.status AS status,
          p.notes AS notes,
          p.created_by AS created_by_id,
          c.name AS created_by,
          p.updated_by AS updated_by_id,
          u.name AS updated_by,
          p.approved_by AS approved_by_id,
          ap.name AS approved_by,
          p.after_shipped_status AS after_shipped_status
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_users AS a ON p.assigned_id = a.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_by = c.id
        LEFT JOIN t_users AS u ON p.updated_by = u.id
        LEFT JOIN t_users AS ap ON p.approved_by = ap.id
        WHERE p.id = ?
        ''',
          [id],
        );

        return responseNewPreparation.first.fields;
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

  @override
  Future<PreparationModel> updateStatusAssignedPreparation({
    required int id,
    required int userId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final responsePreparation = await txn.query(
          'SELECT * FROM t_preparations WHERE id = ? AND status = ?',
          [id, 'DRAFT'],
        );

        if (responsePreparation.firstOrNull == null ||
            responsePreparation.isEmpty) {
          throw NotFoundException(message: 'Preparation not found');
        }

        final preparation = responsePreparation.first.fields;

        final createdBy = preparation['created_by'] as int;

        if (createdBy != userId) {
          throw UpdateException(
            message: 'Failed, You do not have permission to assigned',
          );
        }

        final response = await txn.query(
          '''
        UPDATE t_preparations
        SET status = ?, updated_at = NOW()
        WHERE id = ? AND created_by = ?
        ''',
          ['ASSIGNED', id, userId],
        );

        if (response.affectedRows == null || response.affectedRows == 0) {
          throw UpdateException(
            message: 'Failed assigned preparations, please try again',
          );
        }
        final responseNewPreparation = await db.query(
          '''
        SELECT
          p.id AS id,
          p.preparation_code AS preparation_code,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.assigned_id AS assigned_id,
          a.name AS assigned,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.total_box AS total_box,
          p.status AS status,
          p.notes AS notes,
          p.created_by AS created_by_id,
          c.name AS created_by,
          p.updated_by AS updated_by_id,
          u.name AS updated_by,
          p.approved_by AS approved_by_id,
          ap.name AS approved_by,
          p.after_shipped_status AS after_shipped_status
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_users AS a ON p.assigned_id = a.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_by = c.id
        LEFT JOIN t_users AS u ON p.updated_by = u.id
        LEFT JOIN t_users AS ap ON p.approved_by = ap.id
        WHERE p.id = ?
        ''',
          [id],
        );

        return responseNewPreparation.first.fields;
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

  @override
  Future<PreparationModel> updateStatusCancelledPreparation({
    required int id,
    required int userId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final responsePreparation = await txn.query(
          'SELECT * FROM t_preparations WHERE id = ? AND status = ?',
          [id, 'DRAFT'],
        );

        if (responsePreparation.firstOrNull == null ||
            responsePreparation.isEmpty) {
          throw NotFoundException(message: 'Preparation not found');
        }

        final preparation = responsePreparation.first.fields;

        final createdBy = preparation['created_by'] as int;

        if (createdBy != userId) {
          throw UpdateException(
            message: 'Failed, You do not have permission to cancelled',
          );
        }

        final response = await txn.query(
          '''
        UPDATE t_preparations
        SET status = ?, updated_at = NOW()
        WHERE id = ? AND created_by = ?
        ''',
          ['CANCELLED', id, userId],
        );

        if (response.affectedRows == null || response.affectedRows == 0) {
          throw UpdateException(
            message: 'Failed cancelled preparations, please try again',
          );
        }
        final responseNewPreparation = await db.query(
          '''
        SELECT
          p.id AS id,
          p.preparation_code AS preparation_code,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.assigned_id AS assigned_id,
          a.name AS assigned,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.total_box AS total_box,
          p.status AS status,
          p.notes AS notes,
          p.created_by AS created_by_id,
          c.name AS created_by,
          p.updated_by AS updated_by_id,
          u.name AS updated_by,
          p.approved_by AS approved_by_id,
          ap.name AS approved_by,
          p.after_shipped_status AS after_shipped_status
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_users AS a ON p.assigned_id = a.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_by = c.id
        LEFT JOIN t_users AS u ON p.updated_by = u.id
        LEFT JOIN t_users AS ap ON p.approved_by = ap.id
        WHERE p.id = ?
        ''',
          [id],
        );

        return responseNewPreparation.first.fields;
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

  @override
  Future<PreparationModel> updateStatusCompletedPreparation({
    required int id,
    required int userId,
    required List<int> fileBytes,
    required String originalName,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final responsePreparation = await txn.query(
          'SELECT * FROM t_preparations WHERE id = ? AND status = ?',
          [id, 'APPROVED'],
        );

        if (responsePreparation.firstOrNull == null ||
            responsePreparation.isEmpty) {
          throw NotFoundException(message: 'Preparation not found');
        }

        final preparation = responsePreparation.first.fields;

        final createdBy = preparation['created_by'] as int;

        if (createdBy != userId) {
          throw UpdateException(
            message: 'Failed, You do not have permission to completed',
          );
        }

        if (!originalName.toLowerCase().endsWith('.pdf')) {
          throw UpdateException(message: 'File not valid, only pdf');
        }

        final basePath = Directory.current.path;

        final uploadDir = p.join(basePath, 'uploads', 'preparation');

        final dir = Directory(uploadDir);

        if (!dir.existsSync()) {
          dir.createSync(recursive: true);
        }

        final fileName = '${preparation['preparation_code']}.pdf';

        final savePath = p.join(uploadDir, fileName);

        final file = File(savePath);

        await file.writeAsBytes(fileBytes, flush: true);

        final response = await txn.query(
          '''
        UPDATE t_preparations
        SET status = ?, updated_at = NOW()
        WHERE id = ? AND created_by = ?
        ''',
          ['COMPLETED', id, userId],
        );

        if (response.affectedRows == null || response.affectedRows == 0) {
          throw UpdateException(
            message: 'Failed completed preparations, please try again',
          );
        }
        final responseNewPreparation = await db.query(
          '''
        SELECT
          p.id AS id,
          p.preparation_code AS preparation_code,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.assigned_id AS assigned_id,
          a.name AS assigned,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.total_box AS total_box,
          p.status AS status,
          p.notes AS notes,
          p.created_by AS created_by_id,
          c.name AS created_by,
          p.updated_by AS updated_by_id,
          u.name AS updated_by,
          p.approved_by AS approved_by_id,
          ap.name AS approved_by,
          p.after_shipped_status AS after_shipped_status
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_users AS a ON p.assigned_id = a.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_by = c.id
        LEFT JOIN t_users AS u ON p.updated_by = u.id
        LEFT JOIN t_users AS ap ON p.approved_by = ap.id
        WHERE p.id = ?
        ''',
          [id],
        );

        return responseNewPreparation.first.fields;
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

  @override
  Future<PreparationModel> updateStatusPickingPreparation({
    required int id,
    required int userId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final responsePreparation = await txn.query(
          'SELECT * FROM t_preparations WHERE id = ? AND status = ?',
          [id, 'ASSIGNED'],
        );

        if (responsePreparation.firstOrNull == null ||
            responsePreparation.isEmpty) {
          throw NotFoundException(message: 'Preparation not found');
        }

        final preparation = responsePreparation.first.fields;

        final assignedId = preparation['assigned_id'] as int;

        if (assignedId != userId) {
          throw UpdateException(
            message: 'Failed, You do not have permission to start picking',
          );
        }

        final response = await txn.query(
          '''
        UPDATE t_preparations
        SET status = ?, updated_at = NOW()
        WHERE id = ? AND assigned_id = ?
        ''',
          ['PICKING', id, userId],
        );

        if (response.affectedRows == null || response.affectedRows == 0) {
          throw UpdateException(
            message: 'Failed start picking, please try again',
          );
        }
        final responseNewPreparation = await db.query(
          '''
        SELECT
          p.id AS id,
          p.preparation_code AS preparation_code,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.assigned_id AS assigned_id,
          a.name AS assigned,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.total_box AS total_box,
          p.status AS status,
          p.notes AS notes,
          p.created_by AS created_by_id,
          c.name AS created_by,
          p.updated_by AS updated_by_id,
          u.name AS updated_by,
          p.approved_by AS approved_by_id,
          ap.name AS approved_by,
          p.after_shipped_status AS after_shipped_status
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_users AS a ON p.assigned_id = a.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_by = c.id
        LEFT JOIN t_users AS u ON p.updated_by = u.id
        LEFT JOIN t_users AS ap ON p.approved_by = ap.id
        WHERE p.id = ?
        ''',
          [id],
        );

        return responseNewPreparation.first.fields;
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

  @override
  Future<PreparationModel> updateStatusReadyPreparation({
    required int id,
    required int userId,
    required int locationId,
    required int totalBox,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final responsePreparation = await txn.query(
          'SELECT * FROM t_preparations WHERE id = ? AND status = ?',
          [id, 'PICKING'],
        );

        if (responsePreparation.firstOrNull == null ||
            responsePreparation.isEmpty) {
          throw NotFoundException(message: 'Preparation not found');
        }

        final preparation = responsePreparation.first.fields;

        final assignedId = preparation['assigned_id'] as int;

        if (assignedId != userId) {
          throw UpdateException(
            message: 'Failed, You do not have permission to completed picking',
          );
        }

        final response = await txn.query(
          '''
        UPDATE t_preparations
        SET status = ?, updated_at = NOW(), total_box = ?, temporary_location_id = ?
        WHERE id = ? AND assigned_id = ?
        ''',
          ['READY', totalBox, locationId, id, userId],
        );

        if (response.affectedRows == null || response.affectedRows == 0) {
          throw UpdateException(
            message: 'Failed start picking, please try again',
          );
        }
        final responseNewPreparation = await db.query(
          '''
        SELECT
          p.id AS id,
          p.preparation_code AS preparation_code,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.assigned_id AS assigned_id,
          a.name AS assigned,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.total_box AS total_box,
          p.status AS status,
          p.notes AS notes,
          p.created_by AS created_by_id,
          c.name AS created_by,
          p.updated_by AS updated_by_id,
          u.name AS updated_by,
          p.approved_by AS approved_by_id,
          ap.name AS approved_by,
          p.after_shipped_status AS after_shipped_status
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_users AS a ON p.assigned_id = a.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_by = c.id
        LEFT JOIN t_users AS u ON p.updated_by = u.id
        LEFT JOIN t_users AS ap ON p.approved_by = ap.id
        WHERE p.id = ?
        ''',
          [id],
        );

        return responseNewPreparation.first.fields;
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
