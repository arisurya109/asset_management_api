// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/brands/data/model/brand_model.dart';
import 'package:asset_management_api/features/brands/data/source/brand_local_data_source.dart';

class BrandLocalDataSourceImpl implements BrandLocalDataSource {
  BrandLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<BrandModel> createBrand(BrandModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkBrandName = await txn.query(
        'SELECT COUNT(id) FROM t_brands WHERE UPPER(brand_name) = UPPER(?)',
        [params.brandName],
      );

      if (checkBrandName.first.fields['COUNT(id)'] as int > 0) {
        throw CreateException(
          message: 'Brand name already to exists',
        );
      } else {
        final addBrand = await txn.query(
          '''
          INSERT INTO t_brands (asset_id, brand_code, brand_name)
          VALUES (?, ?, ?)
          ''',
          [params.assetId, params.brandCode, params.brandName],
        );

        if (addBrand.insertId == 0) {
          throw CreateException(
            message: 'Failed to create new brand, please try again',
          );
        } else {
          final newBrand = await txn.query(
            '''
            SELECT
              b.id AS id,
              b.brand_code AS brand_code,
              b.brand_name AS brand_name,
              a.id AS asset_id,
              a.asset_name AS asset_name
            FROM
              t_brands AS b
            LEFT JOIN t_assets AS a ON b.asset_id = a.id
            WHERE b.id = ?
            ''',
            [addBrand.insertId],
          );

          return newBrand.first.fields;
        }
      }
    });

    return BrandModel.fromDatabase(response!);
  }

  @override
  Future<List<BrandModel>> findAllBrand() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        b.id AS id,
        b.brand_code AS brand_code,
        b.brand_name AS brand_name,
        a.id AS asset_id,
        a.asset_name AS asset_name
      FROM
        t_brands AS b
      LEFT JOIN t_assets AS a ON b.asset_id = a.id
      ORDER BY b.id ASC
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'No brand yet, please create first brand',
      );
    }

    return response.map((e) => BrandModel.fromDatabase(e.fields)).toList();
  }

  @override
  Future<BrandModel> findBrandById(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        b.id AS id,
        b.brand_code AS brand_code,
        b.brand_name AS brand_name,
        a.id AS asset_id,
        a.asset_name AS asset_name
      FROM
        t_brands AS b
      LEFT JOIN t_assets AS a ON b.asset_id = a.id
      WHERE b.id = ?
      ''',
      [params],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Not found brand',
      );
    }

    return BrandModel.fromDatabase(response.first.fields);
  }

  @override
  Future<List<BrandModel>> findBrandByIdAsset(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        b.id AS id,
        b.brand_code AS brand_code,
        b.brand_name AS brand_name,
        a.id AS asset_id,
        a.asset_name AS asset_name
      FROM
        t_brands AS b
      LEFT JOIN t_assets AS a ON b.asset_id = a.id
      WHERE b.asset_id = ?
      ORDER BY b.id ASC
      ''',
      [params],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'No brand yet, please create first brand',
      );
    }

    return response.map((e) => BrandModel.fromDatabase(e.fields)).toList();
  }

  @override
  Future<BrandModel> updateBrand(BrandModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkBrand = await txn.query(
        'SELECT COUNT(id) FROM t_brands WHERE id = ?',
        [params.id],
      );

      if (checkBrand.first.fields['COUNT(id)'] == 0) {
        throw UpdateException(message: 'Failed to update, brand not found');
      } else {
        final updateBrand = await txn.query(
          'UPDATE t_brands SET brand_name = ? WHERE id = ?',
          [params.brandName, params.id],
        );

        if (updateBrand.affectedRows == 0) {
          throw UpdateException(
            message: 'Failed to update brand, please try again',
          );
        } else {
          final newBrand = await txn.query(
            '''
            SELECT
              b.id AS id,
              b.brand_code AS brand_code,
              b.brand_name AS brand_name,
              a.id AS asset_id,
              a.asset_name AS asset_name
            FROM
              t_brands AS b
            LEFT JOIN t_assets AS a ON b.asset_id = a.id
            WHERE b.id = ?
            ORDER BY b.id ASC
            ''',
            [params.id],
          );

          return newBrand.first.fields;
        }
      }
    });

    return BrandModel.fromDatabase(response!);
  }
}
