// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/asset_models/data/model/asset_model_models.dart';
import 'package:asset_management_api/features/asset_models/data/source/asset_model_local_data_source.dart';

class AssetModelLocalDataSourceImpl implements AssetModelLocalDataSource {
  AssetModelLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<AssetModelModels> createAssetModel(AssetModelModels params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkName = await txn.query(
        'SELECT COUNT(id) FROM t_asset_models WHERE UPPER(name) = UPPER(?)',
        [params.name],
      );

      if (checkName.first.fields['COUNT(id)'] as int > 0) {
        throw CreateException(
          message: 'Failed to create asset, name already exists',
        );
      } else {
        final response = await txn.query('''
          INSERT INTO t_asset_models(name, has_serial, unit, created_by, type_id, category_id, brand_id)
          VALUES (?, ?, ?, ?, ?, ?, ?)
          ''', [
          params.name,
          params.hasSerial,
          params.unit,
          params.categoryId,
          params.typeId,
          params.categoryId,
          params.brandId,
        ]);

        if (response.insertId == null || response.insertId == 0) {
          throw CreateException(
            message: 'Failed to create asset model, please try again',
          );
        } else {
          final newAssetModel = await txn.query(
            '''
            SELECT
              am.id AS id, 
              am.name AS name,
              am.has_serial AS has_serial,
              am.is_consumable AS is_consumable,
              am.unit AS unit,
              am.type_id AS type_id,
              at.name AS type_name,
              am.category_id AS category_id,
              ac.name AS category_name,
              am.brand_id AS brand_id,
              ab.name AS brand_name
            FROM t_asset_models AS am
            LEFT JOIN t_asset_types AS at ON am.type_id = at.id
            LEFT JOIN t_asset_categories AS ac ON ac.category_id = ac.id
            LEFT JOIN t_asset_brands AS ab ON ac.brand_id = ab.id
            WHERE am.id = ?
            ''',
            [response.insertId],
          );

          return newAssetModel.first.fields;
        }
      }
    });
    return AssetModelModels.fromDatabase(response!);
  }

  @override
  Future<List<AssetModelModels>> findAllAssetModel() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        am.id AS id, 
        am.name AS name,
        am.has_serial AS has_serial,
        am.is_consumable AS is_consumable,
        am.unit AS unit,
        am.type_id AS type_id,
        at.name AS type_name,
        am.category_id AS category_id,
        ac.name AS category_name,
        am.brand_id AS brand_id,
        ab.name AS brand_name
      FROM t_asset_models AS am
      LEFT JOIN t_asset_types AS at ON am.type_id = at.id
      LEFT JOIN t_asset_categories AS ac ON ac.category_id = ac.id
      LEFT JOIN t_asset_brands AS ab ON ac.brand_id = ab.id
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Asset model is empty, please create first',
      );
    }

    return response
        .map((e) => AssetModelModels.fromDatabase(e.fields))
        .toList();
  }

  @override
  Future<AssetModelModels> findByIdAssetModel(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        am.id AS id, 
        am.name AS name,
        am.has_serial AS has_serial,
        am.is_consumable AS is_consumable,
        am.unit AS unit,
        am.type_id AS type_id,
        at.name AS type_name,
        am.category_id AS category_id,
        ac.name AS category_name,
        am.brand_id AS brand_id,
        ab.name AS brand_name
      FROM t_asset_models AS am
      LEFT JOIN t_asset_types AS at ON am.type_id = at.id
      LEFT JOIN t_asset_categories AS ac ON ac.category_id = ac.id
      LEFT JOIN t_asset_brands AS ab ON ac.brand_id = ab.id
      WHERE am.id = ? LIMIT 1
      ''',
      [params],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(message: 'Asset model not found');
    }

    return AssetModelModels.fromDatabase(response.first.fields);
  }

  @override
  Future<AssetModelModels> updateAssetModel(AssetModelModels params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkAssetModel = await txn.query(
        'SELECT COUNT(id) FROM t_asset_models WHERE id = ?',
        [params.id],
      );

      if (checkAssetModel.first.fields['COUNT(id)'] == 0) {
        throw UpdateException(
          message: 'Failed to update, asset model not found',
        );
      } else {
        final updateName = await txn.query(
          '''
          UPDATE t_asset_models
          SET name = ?
          WHERE id = ?
          ''',
          [params.name, params.id],
        );

        if (updateName.affectedRows == null) {
          throw UpdateException(
            message: 'Failed to update, please try again',
          );
        }

        final newAssetModel = await txn.query(
          '''
          SELECT
            am.id AS id, 
            am.name AS name,
            am.has_serial AS has_serial,
            am.is_consumable AS is_consumable,
            am.unit AS unit,
            am.type_id AS type_id,
            at.name AS type_name,
            am.category_id AS category_id,
            ac.name AS category_name,
            am.brand_id AS brand_id,
            ab.name AS brand_name
          FROM t_asset_models AS am
          LEFT JOIN t_asset_types AS at ON am.type_id = at.id
          LEFT JOIN t_asset_categories AS ac ON ac.category_id = ac.id
          LEFT JOIN t_asset_brands AS ab ON ac.brand_id = ab.id
          WHERE am.id = ? LIMIT 1
          ''',
          [params.id],
        );

        return newAssetModel.first.fields;
      }
    });

    return AssetModelModels.fromDatabase(response!);
  }
}
