// ignore_for_file:  sort_constructors_first, strict_raw_type
// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/asset.dart';
import 'package:asset_management_api/features/assets/data/model/assets_detail_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_request_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_response_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_response_pagination_model.dart';
import 'package:asset_management_api/features/assets/data/source/assets_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class AssetsLocalDataSourceImpl implements AssetsLocalDataSource {
  AssetsLocalDataSourceImpl(
    this._database,
    this._databaseErpOld,
  );

  final Database _database;
  final DatabaseErpOld _databaseErpOld;

  @override
  Future<List<AssetsResponseModel>> findAllAssets() async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
      SELECT
	      a.id AS id,
	      a.serial_number AS serial_number,
	      a.asset_code AS asset_code,
	      a.status AS status,
	      a.conditions AS conditions,
	      a.quantity AS quantity,
	      am.unit AS uom,
	      am.name AS model,
	      ac.name AS category,
	      ab.name AS brand,
	      ats.name AS types,
	      c.name AS color,
	      l2.name AS location,
	      l1.name AS location_detail,
	      a.purchase_order AS purchase_order,
	      a.remarks AS remarks
      FROM
      	t_assets AS a
      LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
      LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
      LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
      LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
      LEFT JOIN t_colors AS c ON a.color_id  = c.id
      LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
      LEFT JOIN t_locations AS l2 ON l1.parent_id  = l2.id
      WHERE a.quantity > 0
      ''',
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Assets is empty');
      }

      return response
          .map((e) => AssetsResponseModel.fromMap(e.fields))
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

  Future<Map<String, dynamic>> _getDatasAssetOld(String assetId) async {
    try {
      final dbOld = await _databaseErpOld.connection;

      final response = await dbOld.query(
        '''
      SELECT
	      sn AS serial_number,
	      asset_id AS asset_id_old,
	      po_no AS purchase_order_number
      FROM
        t_asset_id
      WHERE asset_id = ?
      ''',
        [assetId],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(
          message: 'Failed to migrate, asset old is not found',
        );
      }

      return response.first.fields;
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
  Future<List<AssetsDetailModel>> findAssetDetailById(int params) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
      SELECT
        am.id AS id,
	      am.movement_type AS movement_type,
	      l1.name AS from_location,
	      l2.name AS to_location,
	      u.name AS movement_by,
	      am.movement_date,
	      am.references_number AS references_number,
	      am.notes AS notes
      FROM 
      	t_asset_movements AS am
      LEFT JOIN t_locations AS l1 ON am.from_location_id = l1.id
      LEFT JOIN t_locations AS l2 ON am.to_location_id  = l2.id
      LEFT JOIN t_users AS u ON am.movement_by = u.id
      WHERE am.asset_id = ?
      ''',
        [params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Assets no history movement');
      }

      return response
          .map((e) => AssetsDetailModel.fromDatabase(e.fields))
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
  Future<List<AssetsResponseModel>> findAssetByQuery({
    required String params,
  }) async {
    try {
      final db = await _database.connection;

      var whereClause = '';
      var queryArgs = <dynamic>[];

      if (params.trim().isNotEmpty) {
        final pattern = '%${params.trim()}%';

        whereClause = '''
        WHERE 
          a.asset_code LIKE ? OR 
          a.serial_number LIKE ? OR 
          a.status LIKE ? OR 
          a.conditions LIKE ? OR 
          am.name LIKE ? OR 
          ac.name LIKE ? OR 
          ab.name LIKE ? OR 
          ats.name LIKE ? OR 
          c.name LIKE ? OR 
          l1.name LIKE ? OR 
          a.purchase_order LIKE ? OR 
          a.remarks LIKE ?
      ''';

        queryArgs = List.filled(12, pattern);
      }

      final response = await db.query(
        '''
        SELECT
          a.id AS id,
          a.serial_number AS serial_number,
          a.asset_code AS asset_code,
          a.status AS status,
          a.conditions AS conditions,
          a.quantity AS quantity,
          am.unit AS uom,
          am.name AS model,
          ac.name AS category,
          ab.name AS brand,
          ats.name AS types,
          c.name AS color,
          l2.name AS location,
	        l1.name AS location_detail,
          a.purchase_order AS purchase_order,
          a.remarks AS remarks
        FROM
          t_assets AS a
        LEFT JOIN t_asset_models AS am ON a.asset_model_id = am.id
        LEFT JOIN t_asset_brands AS ab ON am.brand_id = ab.id
        LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
        LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
        LEFT JOIN t_colors AS c ON a.color_id = c.id
        LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
        LEFT JOIN t_locations AS l2 ON l1.parent_id  = l2.id
        $whereClause
        ORDER BY a.id DESC
        ''',
        queryArgs,
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Asset not found record');
      } else {
        return response
            .map((row) => AssetsResponseModel.fromMap(row.fields))
            .toList();
      }
    } on NotFoundException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: 'Terjadi kesalahan: $e');
    }
  }

  @override
  Future<AssetsResponseModel> migrationAsset(AssetsRequestModel params) async {
    try {
      final datasOld = await _getDatasAssetOld(params.assetIdOld!);

      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final checkSerialNumberAndAssetIdOld = await txn.query(
          'SELECT COUNT(id) FROM t_assets WHERE serial_number = ? AND asset_id_old = ?',
          [datasOld['serial_number'], datasOld['asset_id_old']],
        );

        if (checkSerialNumberAndAssetIdOld.first.fields['COUNT(id)'] as int >
            0) {
          throw CreateException(message: 'Asset already exists');
        }

        final initTypeCategory = await txn.query(
          '''
            SELECT 
              ac.init AS category_init,
              at.init AS type_init
            FROM t_asset_models AS am
            LEFT JOIN t_asset_categories AS ac ON am.category_id  = ac.id
            LEFT JOIN t_asset_types AS at ON am.type_id  = at.id
            WHERE am.id = ?
            ''',
          [params.assetModelId],
        );

        final templateCode = AssetHelper.templateCode;

        final response = await txn.query(
          'SELECT COUNT(id) FROM t_assets WHERE DATE(registred_at) = CURDATE()',
        );

        const width = 4;

        final count = response.first.fields['COUNT(id)'] as int;
        final lastCode = (count + 1).toString().padLeft(width, '0');

        final categoryInit = initTypeCategory.first.fields['category_init'];
        final typeInit = initTypeCategory.first.fields['type_init'];

        final assetCode = '$typeInit-$categoryInit-$templateCode$lastCode';

        final registredAsset = await txn.query(
          '''
            INSERT INTO t_assets (
              asset_code, 
              asset_id_old,
              serial_number,
              purchase_order, 
              status, 
              conditions, 
              remarks, 
              registred_by, 
              asset_model_id, 
              color_id, 
              quantity, 
              location_id)
            VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
          [
            assetCode,
            datasOld['asset_id_old'],
            datasOld['serial_number'],
            datasOld['purchase_order_number'],
            params.status,
            params.conditions,
            params.remarks,
            params.registredBy,
            params.assetModelId,
            params.colorId,
            1,
            params.locationId,
          ],
        );

        if (registredAsset.insertId == null || registredAsset.insertId == 0) {
          throw CreateException(
            message: 'Failed to migrate asset, please try again',
          );
        }
        final newAsset = await txn.query(
          '''
              SELECT
	              a.id AS id,
	              a.serial_number AS serial_number,
	              a.asset_code AS asset_code,
	              a.status AS status,
	              a.conditions AS conditions,
	              a.quantity AS quantity,
	              am.unit AS uom,
	              am.name AS model,
	              ac.name AS category,
	              ab.name AS brand,
	              ats.name AS types,
	              c.name AS color,
	              l2.name AS location,
	              l1.name AS location_detail,
	              a.purchase_order AS purchase_order,
	              a.remarks AS remarks
              FROM
              	t_assets AS a
              LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
              LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
              LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
              LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
              LEFT JOIN t_colors AS c ON a.color_id  = c.id
              LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
              LEFT JOIN t_locations AS l2 ON l1.parent_id  = l2.id
              WHERE a.id = ?
            ''',
          [registredAsset.insertId],
        );

        return newAsset.first.fields;
      });

      return AssetsResponseModel.fromMap(response!);
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
  Future<AssetsResponseModel> registrationAsset(
    AssetsRequestModel params,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        // Serial Number Not Null or Not Empty
        if (params.serialNumber.isFilled()) {
          final checkSerialNumber = await txn.query(
            'SELECT COUNT(id) FROM t_assets WHERE serial_number = ?',
            [params.serialNumber],
          );

          if (checkSerialNumber.first.fields['COUNT(id)'] == 0) {
            final templateCode = AssetHelper.templateCode;

            final response = await txn.query(
              'SELECT COUNT(id) FROM t_assets WHERE DATE(registred_at) = CURDATE()',
            );

            const width = 4;

            final count = response.first.fields['COUNT(id)'] as int;
            final lastCode = (count + 1).toString().padLeft(width, '0');

            final initTypeCategory = await txn.query(
              '''
            SELECT 
              ac.init AS category_init,
              at.init AS type_init
            FROM t_asset_models AS am
            LEFT JOIN t_asset_categories AS ac ON am.category_id  = ac.id
            LEFT JOIN t_asset_types AS at ON am.type_id  = at.id
            WHERE am.id = ?
            ''',
              [params.assetModelId],
            );

            final categoryInit = initTypeCategory.first.fields['category_init'];
            final typeInit = initTypeCategory.first.fields['type_init'];

            final assetCode = '$typeInit-$categoryInit-$templateCode$lastCode';

            final registredAsset = await txn.query(
              '''
            INSERT INTO t_assets (
              asset_code, 
              serial_number, 
              status, 
              conditions, 
              remarks, 
              registred_by, 
              asset_model_id, 
              color_id, 
              purchase_order, 
              quantity, 
              location_id)
            VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
              [
                assetCode,
                params.serialNumber,
                params.status,
                params.conditions,
                params.remarks,
                params.registredBy,
                params.assetModelId,
                params.colorId,
                params.purchaseOrder,
                1,
                params.locationId,
              ],
            );

            if (registredAsset.insertId == null ||
                registredAsset.insertId == 0) {
              throw CreateException(message: 'Failed to create asset code');
            } else {
              final newAsset = await txn.query(
                '''
              SELECT
	              a.id AS id,
	              a.serial_number AS serial_number,
	              a.asset_code AS asset_code,
	              a.status AS status,
	              a.conditions AS conditions,
	              a.quantity AS quantity,
	              am.unit AS uom,
	              am.name AS model,
	              ac.name AS category,
	              ab.name AS brand,
	              ats.name AS types,
	              c.name AS color,
	              l2.name AS location,
	              l1.name AS location_detail,
	              a.purchase_order AS purchase_order,
	              a.remarks AS remarks
              FROM
              	t_assets AS a
              LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
              LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
              LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
              LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
              LEFT JOIN t_colors AS c ON a.color_id  = c.id
              LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
              LEFT JOIN t_locations AS l2 ON l1.parent_id  = l2.id
                WHERE a.id = ?
            ''',
                [registredAsset.insertId],
              );
              return newAsset.first.fields;
            }
          } else {
            throw CreateException(
              message:
                  'Failed to create asset, serial number already to exists',
            );
          }
        } else if (params.uom == 1) {
          final templateCode = AssetHelper.templateCode;

          final response = await txn.query(
            'SELECT COUNT(id) FROM t_assets WHERE DATE(registred_at) = CURDATE()',
          );
          const width = 4;

          final count = response.first.fields['COUNT(id)'] as int;
          final lastCode = (count + 1).toString().padLeft(width, '0');

          final initTypeCategory = await txn.query(
            '''
            SELECT 
              ac.init AS category_init,
              at.init AS type_init
            FROM t_asset_models AS am
            LEFT JOIN t_asset_categories AS ac ON am.category_id  = ac.id
            LEFT JOIN t_asset_types AS at ON am.type_id  = at.id
            WHERE am.id = ?
            ''',
            [params.assetModelId],
          );

          final categoryInit = initTypeCategory.first.fields['category_init'];
          final typeInit = initTypeCategory.first.fields['type_init'];

          final assetCode = '$typeInit-$categoryInit-$templateCode$lastCode';

          final registredAsset = await txn.query(
            '''
            INSERT INTO t_assets (
              asset_code,
              serial_number,
              status, 
              conditions, 
              remarks, 
              registred_by, 
              asset_model_id, 
              color_id, 
              purchase_order, 
              quantity, 
              location_id)
            VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
            [
              assetCode,
              params.serialNumber,
              params.status,
              params.conditions,
              params.remarks,
              params.registredBy,
              params.assetModelId,
              params.colorId,
              params.purchaseOrder,
              1,
              params.locationId,
            ],
          );

          if (registredAsset.insertId == null || registredAsset.insertId == 0) {
            throw CreateException(message: 'Failed to create asset code');
          } else {
            final newAsset = await txn.query(
              '''
            SELECT
	            a.id AS id,
	            a.serial_number AS serial_number,
	            a.asset_code AS asset_code,
	            a.status AS status,
	            a.conditions AS conditions,
	            a.quantity AS quantity,
	            am.unit AS uom,
	            am.name AS model,
	            ac.name AS category,
	            ab.name AS brand,
	            ats.name AS types,
	            c.name AS color,
	            l2.name AS location,
	            l1.name AS location_detail,
	            a.purchase_order AS purchase_order,
	            a.remarks AS remarks
            FROM
              t_assets AS a
            LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
            LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
            LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
            LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
            LEFT JOIN t_colors AS c ON a.color_id  = c.id
            LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
            LEFT JOIN t_locations AS l2 ON l1.parent_id  = l2.id
            WHERE a.id = ?
            ''',
              [registredAsset.insertId],
            );
            return newAsset.first.fields;
          }
        } else {
          // Asset Consumable
          final checkAssetLocation = await txn.query(
            'SELECT id FROM t_assets WHERE asset_model_id = ? AND location_id = ?',
            [params.assetModelId, params.locationId],
          );

          int idAsset;

          if (checkAssetLocation.firstOrNull == null) {
            // Insert
            final newAsset = await txn.query(
              '''
          INSERT INTO t_assets
            (asset_model_id, quantity, location_id, registred_by)
          VALUES
            (?, ?, ?, ?)
          ''',
              [
                params.assetModelId,
                params.quantity,
                params.locationId,
                params.registredBy,
              ],
            );
            idAsset = newAsset.insertId!;
          } else {
            // Update Quantity
            idAsset = checkAssetLocation.first.fields['id'] as int;
            final response = await txn.query(
              '''
          UPDATE t_assets
          SET quantity = quantity + ?
          WHERE id = ?
          ''',
              [params.quantity, idAsset],
            );

            if (response.affectedRows == 0) {
              throw CreateException(
                message: 'Failed to update quantity asset',
              );
            }
          }

          final newAsset = await txn.query(
            '''
              SELECT
	              a.id AS id,
	              a.serial_number AS serial_number,
	              a.asset_code AS asset_code,
	              a.status AS status,
	              a.conditions AS conditions,
	              a.quantity AS quantity,
	              am.unit AS uom,
	              am.name AS model,
	              ac.name AS category,
	              ab.name AS brand,
	              ats.name AS types,
	              c.name AS color,
	              l2.name AS location,
	              l1.name AS location_detail,
	              a.purchase_order AS purchase_order,
	              a.remarks AS remarks
              FROM
              	t_assets AS a
              LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
              LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
              LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
              LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
              LEFT JOIN t_colors AS c ON a.color_id  = c.id
              LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
              LEFT JOIN t_locations AS l2 ON l1.parent_id  = l2.id
                WHERE a.id = ?
            ''',
            [idAsset],
          );
          return newAsset.first.fields;
        }
      });
      return AssetsResponseModel.fromMap(response!);
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
  Future<AssetsResponsePaginationModel> findAssetByPagination({
    required int page,
    required int limit,
    String? query,
  }) async {
    if (query.isFilled()) {
      return _paginationWithQuery(page: page, limit: limit, query: query!);
    } else {
      return _paginationWithoutQuery(page: page, limit: limit);
    }
  }

  Future<AssetsResponsePaginationModel> _paginationWithoutQuery({
    required int page,
    required int limit,
  }) async {
    try {
      final db = await _database.connection;

      final offset = (page - 1) * limit;

      final response = await db.query(
        '''
        SELECT
	        a.id AS id,
	        a.serial_number AS serial_number,
	        a.asset_code AS asset_code,
	        a.status AS status,
	        a.conditions AS conditions,
	        a.quantity AS quantity,
	        am.unit AS uom,
	        am.name AS model,
	        ac.name AS category,
	        ab.name AS brand,
	        ats.name AS types,
	        c.name AS color,
	        l2.name AS location,
	        l1.name AS location_detail,
	        a.purchase_order AS purchase_order,
	        a.remarks AS remarks
        FROM
        	t_assets AS a
        LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
        LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
        LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
        LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
        LEFT JOIN t_colors AS c ON a.color_id  = c.id
        LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
        LEFT JOIN t_locations AS l2 ON l1.parent_id  = l2.id
        WHERE a.quantity > 0
        ORDER BY a.id ASC
        LIMIT ? OFFSET ?
        ''',
        [limit, offset],
      );

      final responseTotalData = await db.query(
        'SELECT COUNT(*) AS total FROM t_assets WHERE quantity > 0',
      );

      final totalData = responseTotalData.first.fields['total'] as int;
      final currentPage = page;
      final lastPage = (totalData / limit).ceil();
      final data = response.map((e) => e.fields).toList();

      final datas = {
        'total_data': totalData,
        'current_page': currentPage,
        'last_page': lastPage,
        'limit': limit,
        'data': data,
      };

      return AssetsResponsePaginationModel.fromDatabase(datas);
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

  Future<AssetsResponsePaginationModel> _paginationWithQuery({
    required int page,
    required int limit,
    required String query,
  }) async {
    try {
      final db = await _database.connection;
      final offset = (page - 1) * limit;

      var whereClause = 'WHERE a.quantity > 0';
      var queryArgs = <dynamic>[];

      final pattern = '%${query.trim()}%';
      whereClause += '''
        AND (
          a.asset_code LIKE ? OR 
          a.serial_number LIKE ? OR 
          a.status LIKE ? OR 
          a.conditions LIKE ? OR 
          am.name LIKE ? OR 
          ac.name LIKE ? OR 
          ab.name LIKE ? OR 
          ats.name LIKE ? OR 
          c.name LIKE ? OR 
          l1.name LIKE ? OR 
          a.purchase_order LIKE ? OR 
          a.remarks LIKE ?
        )
      ''';
      queryArgs = List.filled(12, pattern);

      final dataArgs = [
        ...queryArgs,
        limit,
        offset,
      ];
      final response = await db.query(
        '''
      SELECT
        a.id AS id,
        a.serial_number AS serial_number,
        a.asset_code AS asset_code,
        a.status AS status,
        a.conditions AS conditions,
        a.quantity AS quantity,
        am.unit AS uom,
        am.name AS model,
        ac.name AS category,
        ab.name AS brand,
        ats.name AS types,
        c.name AS color,
        l2.name AS location,
        l1.name AS location_detail,
        a.purchase_order AS purchase_order,
        a.remarks AS remarks
      FROM
        t_assets AS a
      LEFT JOIN t_asset_models AS am ON a.asset_model_id = am.id
      LEFT JOIN t_asset_brands AS ab ON am.brand_id = ab.id
      LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
      LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
      LEFT JOIN t_colors AS c ON a.color_id = c.id
      LEFT JOIN t_locations AS l1 ON a.location_id = l1.id
      LEFT JOIN t_locations AS l2 ON l1.parent_id = l2.id
      $whereClause
      ORDER BY a.id ASC
      LIMIT ? OFFSET ?
      ''',
        dataArgs,
      );

      final totalResponse = await db.query(
        '''
      SELECT COUNT(*) AS total 
      FROM t_assets AS a
      LEFT JOIN t_asset_models AS am ON a.asset_model_id = am.id
      LEFT JOIN t_asset_brands AS ab ON am.brand_id = ab.id
      LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
      LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
      LEFT JOIN t_colors AS c ON a.color_id = c.id
      LEFT JOIN t_locations AS l1 ON a.location_id = l1.id
      $whereClause
      ''',
        queryArgs,
      );

      final totalData = totalResponse.first.fields['total'] as int;

      final List data;

      if (response.isEmpty) {
        data = [];
      } else {
        data = response.map((e) => e.fields).toList();
      }

      final result = {
        'total_data': totalData,
        'current_page': page,
        'last_page': (totalData / limit).ceil(),
        'limit': limit,
        'data': data,
      };

      return AssetsResponsePaginationModel.fromDatabase(result);
    } on NotFoundException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: 'Terjadi kesalahan database: $e');
    }
  }
}
