// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/categories/data/model/category_model.dart';
import 'package:asset_management_api/features/categories/data/source/category_local_data_source.dart';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  CategoryLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<CategoryModel> createCategory(CategoryModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final result = await txn.query(
        'SELECT category_code FROM t_categories ORDER BY id DESC LIMIT 1',
      );

      String categoryCode;

      if (result.isEmpty) {
        categoryCode = 'D0001';
      } else {
        final lastCode = result.first['category_code'] as String;
        final lastNumber = int.parse(lastCode.substring(1));
        final nextNumber = lastNumber + 1;

        categoryCode = 'D${nextNumber.toString().padLeft(4, '0')}';
      }

      final checkAsset = await txn.query(
        '''
        SELECT COUNT(id)
        FROM t_categories
        WHERE UPPER(asset_name) = UPPER(?)
        ''',
        [params.categoryName],
      );

      if (checkAsset.first.fields['COUNT(id)'] as int > 0) {
        throw CreateException(
          message: 'Failed to add asset, asset name already to exists',
        );
      } else {
        final addNewAsset = await txn.query(
          '''
          INSERT INTO t_categories (category_code, category_name, category_init)
          VALUES (?, ?, ?)
          ''',
          [
            categoryCode,
            params.categoryName!.toUpperCase(),
            params.categoryInit!.toUpperCase(),
          ],
        );

        if (addNewAsset.insertId == 0 || addNewAsset.insertId == null) {
          throw CreateException(
            message: 'Failed to add asset, please try again',
          );
        }

        final assetNew = await txn.query(
          'SELECT * FROM t_categories WHERE id = ?',
          [addNewAsset.insertId],
        );

        return assetNew.first.fields;
      }
    });

    return CategoryModel.fromMap(response!);
  }

  @override
  Future<List<CategoryModel>> findAllCategory() async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_categories ORDER BY id ASC',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Not categories yet, please add first asset',
      );
    }

    return response.map((e) => CategoryModel.fromMap(e.fields)).toList();
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final response = await txn.query(
        'SELECT COUNT(id) FROM t_categories WHERE id = ?',
        [params.id],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(
          message: 'Failed to update asset, asset not found',
        );
      }

      final updateAsset = await txn.query(
        'UPDATE t_categories SET asset_name = ? WHERE id = ?',
        [params.categoryName?.toUpperCase(), params.id],
      );

      if (updateAsset.affectedRows == 0 || updateAsset.affectedRows == null) {
        throw UpdateException(
          message: 'Failed to update asset, please try again',
        );
      }

      final newAsset = await txn.query(
        'SELECT * FROM t_categories WHERE id = ?',
        [params.id],
      );

      return newAsset.first.fields;
    });

    return CategoryModel.fromMap(response!);
  }

  @override
  Future<CategoryModel> findCategoryById(int id) async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_categories WHERE id = ?',
      [id],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(message: 'Failed to get asset, not found asset');
    }

    return CategoryModel.fromMap(response.first.fields);
  }
}
