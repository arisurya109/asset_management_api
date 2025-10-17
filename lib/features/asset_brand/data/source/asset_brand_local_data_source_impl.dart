// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/asset_brand/data/model/asset_brand_model.dart';
import 'package:asset_management_api/features/asset_brand/data/source/asset_brand_local_data_source.dart';

class AssetBrandLocalDataSourceImpl implements AssetBrandLocalDataSource {
  AssetBrandLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<AssetBrandModel> createAssetBrand(AssetBrandModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkName = await txn.query(
        'SELECT COUNT(id) FROM t_asset_brands WHERE UPPER(name) = UPPER(?)',
        [params.name],
      );

      if (checkName.first.fields['COUNT(id)'] as int > 0) {
        throw CreateException(
          message: 'Failed to create asset brand, name already exists',
        );
      } else {
        final createBrand = await txn.query(
          'INSERT INTO t_asset_brands(name, init) VALUES (?, ?)',
          [params.name?.toUpperCase(), params.init?.toUpperCase()],
        );

        if (createBrand.insertId == null || createBrand.insertId == 0) {
          throw CreateException(
            message: 'Failed to create asset brand, please try again',
          );
        } else {
          final newBrand = await txn.query(
            'SELECT * FROM t_asset_brands WHERE id = ?',
            [createBrand.insertId],
          );

          return newBrand.first.fields;
        }
      }
    });

    return AssetBrandModel.fromDatabase(response!);
  }

  @override
  Future<List<AssetBrandModel>> findAllAssetBrand() async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_asset_brands',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Asset brand still empty, please create first',
      );
    }

    return response.map((e) => AssetBrandModel.fromDatabase(e.fields)).toList();
  }

  @override
  Future<AssetBrandModel> findByIdAssetBrand(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_asset_brands WHERE id = ? LIMIT 1',
      [params],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Failed to get asset brand, asset brand not found',
      );
    }

    return AssetBrandModel.fromDatabase(response.first.fields);
  }

  @override
  Future<AssetBrandModel> updateAssetBrand(AssetBrandModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkBrand = await txn.query(
        'SELECT COUNT(id) FROM t_asset_brands WHERE id = ?',
        [params.id],
      );

      if (checkBrand.first.fields['COUNT(id)'] == 0) {
        throw UpdateException(
          message: 'Failed to update, asset brand not found',
        );
      } else {
        final updateBrand = await txn.query(
          'UPDATE t_asset_brands SET name = ? WHERE id = ?',
          [params.name, params.id],
        );

        if (updateBrand.affectedRows == null) {
          throw UpdateException(message: 'Failed to update, please try again');
        } else {
          final newBrand = await txn.query(
            'SELECT * FROM t_asset_brands WHERE id = ?',
            [params.id],
          );

          return newBrand.first.fields;
        }
      }
    });
    return AssetBrandModel.fromDatabase(response!);
  }
}
