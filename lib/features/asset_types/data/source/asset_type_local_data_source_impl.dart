// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/asset_types/asset_type_export.dart';

class AssetTypeLocalDataSourceImpl implements AssetTypeLocalDataSource {
  AssetTypeLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<AssetTypeModel> createAssetType(AssetTypeModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkTypeName = await txn.query(
        'SELECT COUNT(id) FROM t_asset_types WHERE UPPER(type_name) = UPPER(?)',
        [params.typeName],
      );

      if (checkTypeName.first.fields['COUNT(id)'] as int > 0) {
        throw CreateException(
          message: 'Failed create asset type, type name already to exists',
        );
      } else {
        final addNewType = await txn.query(
          '''
          INSERT INTO t_asset_types (brand_id, type_name)
          VALUES (?, ?)
          ''',
          [params.brandId, params.typeName],
        );

        if (addNewType.insertId == 0) {
          throw CreateException(
            message: 'Failed to create new asset type, please try again',
          );
        }

        final newType = await txn.query(
          '''
          SELECT
            t.id AS id,
            t.type_name AS type_name,
            b.id AS brand_id,
            b.brand_name AS brand_name
          FROM
            t_asset_types AS t
          LEFT JOIN t_brands AS b ON t.brand_id = b.id
          WHERE t.id = ?
          ''',
          [addNewType.insertId],
        );

        return newType.first.fields;
      }
    });

    return AssetTypeModel.fromMap(response!);
  }

  @override
  Future<List<AssetTypeModel>> findAllAssetType() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        t.id AS id,
        t.type_name AS type_name,
        b.id AS brand_id,
        b.brand_name AS brand_name
      FROM
        t_asset_types AS t
        LEFT JOIN t_brands AS b ON t.brand_id = b.id
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Not asset type yet, please add first asset type',
      );
    }

    return response.map((e) => AssetTypeModel.fromMap(e.fields)).toList();
  }

  @override
  Future<AssetTypeModel> findAssetTypeById(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        t.id AS id,
        t.type_name AS type_name,
        b.id AS brand_id,
        b.brand_name AS brand_name
      FROM
        t_asset_types AS t
        LEFT JOIN t_brands AS b ON t.brand_id = b.id
      WHERE b.id = ?
      ''',
      [params],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Asset type not found',
      );
    }

    return AssetTypeModel.fromMap(response.first.fields);
  }

  @override
  Future<List<AssetTypeModel>> findAssetTypeByIdBrand(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        t.id AS id,
        t.type_name AS type_name,
        b.id AS brand_id,
        b.brand_name AS brand_name
      FROM
        t_asset_types AS t
        LEFT JOIN t_brands AS b ON t.brand_id = b.id
      WHERE t.brand_id = ?
      ''',
      [params],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Asset type by brand not found',
      );
    }

    return response.map((e) => AssetTypeModel.fromMap(e.fields)).toList();
  }

  @override
  Future<AssetTypeModel> updateAssetType(AssetTypeModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkType = await txn.query(
        'SELECT COUNT(id) FROM t_asset_types WHERE id = ?',
        [params.id],
      );

      if (checkType.first.fields['COUNT(id)'] == 0) {
        throw UpdateException(
          message: 'Failed to update asset type, asset type not found',
        );
      } else {
        final updateType = await txn.query(
          'UPDATE t_asset_types SET type_name = ? WHERE id = ?',
          [params.typeName, params.id],
        );

        if (updateType.affectedRows == 0) {
          throw UpdateException(
            message: 'Failed to update asset type, please try again',
          );
        }

        final newType = await txn.query(
          '''
          SELECT
            t.id AS id,
            t.type_name AS type_name,
            b.id AS brand_id,
            b.brand_name AS brand_name
          FROM
            t_asset_types AS t
          LEFT JOIN t_brands AS b ON t.brand_id = b.id
          WHERE t.id = ?
          ''',
          [params.id],
        );

        return newType.first.fields;
      }
    });

    return AssetTypeModel.fromMap(response!);
  }
}
