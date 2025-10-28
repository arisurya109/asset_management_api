// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/asset_type/data/model/type_model.dart';
import 'package:asset_management_api/features/asset_type/data/source/asset_type_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class AssetTypeLocalDataSourceImpl implements AssetTypeLocalDataSource {
  AssetTypeLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<AssetTypeModel> createType(AssetTypeModel params) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        'INSERT INTO t_asset_types(name, init) VALUES (?, init)',
        [params.name],
      );

      params.id = response.insertId;

      return params;
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
  Future<List<AssetTypeModel>> findAllType() async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        'SELECT * FROM t_asset_types',
      );

      return response
          .map((e) => AssetTypeModel.fromDatabase(e.fields))
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
  Future<AssetTypeModel> findByIdType(int params) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        'SELECT * FROM t_asset_types WHERE id = ?',
        [params],
      );

      return AssetTypeModel.fromDatabase(response.first.fields);
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
  Future<AssetTypeModel> updateType(AssetTypeModel params) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        'UPDATE t_asset_types SET name = ? WHERE id = ?',
        [params.name, params.id],
      );

      if (response.affectedRows == 0 || response.affectedRows == null) {
        throw UpdateException(message: 'Failed to update');
      }

      return params;
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
