// ignore_for_file: unnecessary_await_in_return

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
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
      return await _createPreparationInternal(params);
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

        return destinationMap;
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
  Future<List<PreparationModel>> findPreparationByPagination(
      {required int page, required int limit, String? query}) {
    // TODO: implement findPreparationByPagination
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getPreparationTypes() {
    // TODO: implement getPreparationTypes
    throw UnimplementedError();
  }

  @override
  Future<PreparationModel> updatePreparationStatus(
      {required String params, required int userId}) {
    // TODO: implement updatePreparationStatus
    throw UnimplementedError();
  }
}
