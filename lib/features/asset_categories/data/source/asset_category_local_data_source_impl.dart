// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/asset_categories/data/model/asset_category_model.dart';
import 'package:asset_management_api/features/asset_categories/data/source/asset_category_local_data_source.dart';

class AssetCategoryLocalDataSourceImpl implements AssetCategoryLocalDataSource {
  AssetCategoryLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<AssetCategoryModel> createAssetCategory(
    AssetCategoryModel params,
  ) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkNameAndInit = await txn.query(
        '''
        SELECT COUNT(id) 
        FROM t_asset_categories 
        WHERE UPPER(name) = UPPER(?) OR UPPER(init) = UPPER(?)
        ''',
        [params.name, params.init],
      );

      if (checkNameAndInit.first.fields['COUNT(id)'] as int > 0) {
        throw CreateException(
          message:
              'Failed to create asset category, name or init already exists',
        );
      } else {
        final newIdCategory = await txn.query(
          'INSERT INTO t_asset_categories(name, init) VALUES (?, ?)',
          [params.name, params.init],
        );

        if (newIdCategory.insertId == null || newIdCategory.insertId == 0) {
          throw CreateException(
            message: 'Failed to create new asset category, please try again',
          );
        } else {
          params.id = newIdCategory.insertId;

          return params;
        }
      }
    });
    return response!;
  }

  @override
  Future<List<AssetCategoryModel>> findAllAssetCategory() async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_asset_categories',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Failed to get all asset category, asset is empty',
      );
    } else {
      return response
          .map((e) => AssetCategoryModel.fromDatabase(e.fields))
          .toList();
    }
  }

  @override
  Future<AssetCategoryModel> findByIdAssetCategory(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_categories WHERE id = ? LIMIT 1',
      [params],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(message: 'Asset category not found');
    }

    return AssetCategoryModel.fromDatabase(response.first.fields);
  }

  @override
  Future<AssetCategoryModel> updateAssetCategory(
    AssetCategoryModel params,
  ) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkCategory = await txn.query(
        'SELECT COUNT(id) FROM t_asset_categories WHERE id = ?',
        [params.id],
      );

      if (checkCategory.first.fields['COUNT(id)'] == 0) {
        throw UpdateException(
          message: 'Failed to update asset category, asset not found',
        );
      }

      final newCategory = await txn.query(
        'UPDATE t_asset_categories SET name = ? WHERE id = ?',
        [params.name, params.id],
      );

      if (newCategory.affectedRows == 0) {
        throw UpdateException(
          message: 'Failed to update asset category, please try again',
        );
      } else {
        final category = await txn.query(
          'SELECT * FROM t_categories WHERE id = ? LIMIT 1',
          [params],
        );

        return category.first.fields;
      }
    });

    return AssetCategoryModel.fromDatabase(response!);
  }
}
