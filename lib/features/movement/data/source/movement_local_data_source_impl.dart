// ignore_for_file: lines_longer_than_80_chars, unnecessary_await_in_return, public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/movement/data/model/movement_model.dart';
import 'package:asset_management_api/features/movement/data/source/movement_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class MovementLocalDataSourceImpl implements MovementLocalDataSource {
  MovementLocalDataSourceImpl(this._database);

  final Database _database;
  @override
  Future<String> createMovement({
    required MovementModel params,
    required int userId,
  }) async {
    if (params.type == 'TRANSFER') {
      return await _movementTransfer(params, userId);
    } else if (params.type == 'PREPARATION') {
      return await _movementPreparation(params, userId);
    } else if (params.type == 'RETURN') {
      return await _movementReturn(params, userId);
    } else {
      throw NotFoundException(message: 'Method not allowed');
    }
  }

  Future<String> _movementReturn(
    MovementModel params,
    int userId,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final rFromLocation = await txn.query(
          'SELECT * FROM t_locations WHERE UPPER(name) = UPPER(?) AND is_active = ? LIMIT 1',
          [params.fromLocation, 1],
        );

        final rDestination = await txn.query(
          'SELECT * FROM t_locations WHERE UPPER(name) = UPPER(?) AND is_active = ? LIMIT 1',
          [params.destination, 1],
        );

        if (rFromLocation.first.fields['is_storage'] == 1) {
          throw NotFoundException(
            message: 'The location is now in storage.',
          );
        }

        if (rDestination.firstOrNull == null) {
          throw NotFoundException(message: 'Destination not found');
        }

        if (rDestination.first.fields['is_storage'] == 0) {
          throw NotFoundException(message: 'Destination location is invalid');
        }

        final rAsset = await txn.query(
          'SELECT * FROM t_assets WHERE id = ? LIMIT 1',
          [params.assetId],
        );

        if (rAsset.firstOrNull == null) {
          throw NotFoundException(message: 'Asset not found');
        }

        final fromLocation = rFromLocation.first.fields;
        final destination = rDestination.first.fields;
        final asset = rAsset.first.fields;
        final idUser = userId;

        final responseMovement = await txn.query(
          '''
          INSERT INTO t_asset_movements
            (asset_id, movement_type, from_location_id, to_location_id, movement_by, quantity, notes)
          VALUES
            (?, ?, ?, ?, ?, ?, ?)
          ''',
          [
            params.assetId,
            'RETURN',
            fromLocation['id'],
            destination['id'],
            idUser,
            1,
            params.remarks,
          ],
        );

        if (responseMovement.insertId == null) {
          throw CreateException(
            message:
                'Failed accepted asset ${asset['asset_code']} to ${params.destination}',
          );
        }

        final responseUpdate = await txn.query(
          '''
        UPDATE t_assets
        SET location_id = ?, updated_by = ?, status = ?, conditions = ?, remarks = ?,updated_at = CURRENT_TIMESTAMP()
        WHERE id = ? AND location_id = ?
        ''',
          [
            destination['id'],
            userId,
            params.status,
            params.conditions,
            params.remarks,
            params.assetId,
            fromLocation['id'],
          ],
        );

        if (responseUpdate.affectedRows == null) {
          txn.rollback();
          throw CreateException(
            message:
                'Failed accepted asset ${asset['asset_code']} to ${params.destination}',
          );
        } else {
          return 'Successfully accepted asset ${asset['asset_code']} To ${params.destination}';
        }
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

  Future<String> _movementPreparation(
    MovementModel params,
    int userId,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        params.conditions = params.status == 'USE' ? 'OLD' : 'BAD';
        final rFromLocation = await txn.query(
          'SELECT * FROM t_locations WHERE UPPER(name) = UPPER(?) AND is_active = ? LIMIT 1',
          [params.fromLocation, 1],
        );

        final rDestination = await txn.query(
          'SELECT * FROM t_locations WHERE UPPER(name) = UPPER(?) AND is_active = ? LIMIT 1',
          [params.destination, 1],
        );

        if (rFromLocation.first.fields['is_storage'] == 0) {
          throw NotFoundException(
            message: 'Location is not currently in storage',
          );
        }

        if (rDestination.firstOrNull == null) {
          throw NotFoundException(message: 'Destination not found');
        }

        if (rDestination.first.fields['is_storage'] == 1) {
          throw NotFoundException(message: 'Destination location is invalid');
        }

        final rAsset = await txn.query(
          'SELECT * FROM t_assets WHERE id = ? LIMIT 1',
          [params.assetId],
        );

        if (rAsset.firstOrNull == null) {
          throw NotFoundException(message: 'Asset not found');
        }

        final fromLocation = rFromLocation.first.fields;
        final destination = rDestination.first.fields;
        final asset = rAsset.first.fields;
        final idUser = userId;

        final responseMovement = await txn.query(
          '''
          INSERT INTO t_asset_movements
            (asset_id, movement_type, from_location_id, to_location_id, movement_by, quantity, notes)
          VALUES
            (?, ?, ?, ?, ?, ?, ?)
          ''',
          [
            params.assetId,
            'PREPARATION',
            fromLocation['id'],
            destination['id'],
            idUser,
            1,
            params.remarks,
          ],
        );

        if (responseMovement.insertId == null) {
          throw CreateException(
            message:
                'Failed shipped asset ${asset['asset_code']} to ${params.destination}',
          );
        }

        final responseUpdate = await txn.query(
          '''
        UPDATE t_assets
        SET location_id = ?, updated_by = ?, status = ?, conditions = ?, remarks = ?, updated_at = CURRENT_TIMESTAMP()
        WHERE id = ? AND location_id = ?
        ''',
          [
            destination['id'],
            userId,
            params.status,
            params.conditions,
            params.remarks,
            params.assetId,
            fromLocation['id'],
          ],
        );

        if (responseUpdate.affectedRows == null) {
          txn.rollback();
          throw CreateException(
            message:
                'Failed shipped asset ${asset['asset_code']} to ${params.destination}',
          );
        } else {
          return 'Successfully shipped asset ${asset['asset_code']} To ${params.destination}';
        }
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

  Future<String> _movementTransfer(
    MovementModel params,
    int userId,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final rFromLocation = await txn.query(
          'SELECT * FROM t_locations WHERE UPPER(name) = UPPER(?) AND is_active = ? AND is_storage = ? LIMIT 1',
          [params.fromLocation, 1, 1],
        );

        if (rFromLocation.firstOrNull == null) {
          throw CreateException(message: 'Current location asset cannot valid');
        }

        final rDestination = await txn.query(
          'SELECT * FROM t_locations WHERE UPPER(name) = UPPER(?) AND is_active = ? LIMIT 1',
          [params.destination, 1],
        );

        if (rDestination.firstOrNull == null) {
          throw NotFoundException(message: 'Destination not found');
        }

        if (rDestination.first.fields['is_storage'] == 0) {
          throw NotFoundException(message: 'Destination location is invalid');
        }

        final rAsset = await txn.query(
          'SELECT * FROM t_assets WHERE id = ? LIMIT 1',
          [params.assetId],
        );

        if (rAsset.firstOrNull == null) {
          throw NotFoundException(message: 'Asset not found');
        }

        final fromLocation = rFromLocation.first.fields;
        final destination = rDestination.first.fields;
        final asset = rAsset.first.fields;
        final idUser = userId;

        final responseMovement = await txn.query(
          '''
          INSERT INTO t_asset_movements
            (asset_id, movement_type, from_location_id, to_location_id, movement_by, quantity)
          VALUES
            (?, ?, ?, ?, ?, ?)
          ''',
          [
            params.assetId,
            'TRANSFER',
            fromLocation['id'],
            destination['id'],
            idUser,
            1,
          ],
        );
        if (responseMovement.insertId == null) {
          throw CreateException(
            message:
                'Failed transfer asset ${asset['asset_code']} to ${params.destination}',
          );
        }

        final responseUpdate = await txn.query(
          '''
        UPDATE t_assets
        SET location_id = ?, updated_by = ?, updated_at = CURRENT_TIMESTAMP()
        WHERE id = ? AND location_id = ?
        ''',
          [destination['id'], userId, params.assetId, fromLocation['id']],
        );

        if (responseUpdate.affectedRows == null) {
          throw CreateException(
            message:
                'Failed transfer asset ${asset['asset_code']} to ${params.destination}',
          );
        } else {
          return 'Successfully transfer asset ${asset['asset_code']} To ${params.destination}';
        }
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
}
