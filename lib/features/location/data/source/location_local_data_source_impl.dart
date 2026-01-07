// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, unnecessary_await_in_return, non_constant_identifier_names, override_on_non_overriding_member

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/features/location/data/model/location_model.dart';
import 'package:asset_management_api/features/location/data/model/location_pagination_model.dart';
import 'package:asset_management_api/features/location/data/source/location_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  LocationLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<LocationModel> createLocation(
    LocationModel params,
    int userId,
  ) async {
    try {
      final db = await _database.connection;

      final checkName = await db.query(
        'SELECT id FROM t_locations WHERE UPPER(name) = ? AND is_active = 1',
        [params.name?.toUpperCase()],
      );

      if (checkName.firstOrNull != null) {
        throw CreateException(
          message: 'Failed create location, name already exists',
        );
      }

      if (params.init.isFilled()) {
        final checkInit = await db.query(
          'SELECT id FROM t_locations WHERE UPPER(init) = ? AND is_active = 1',
          [params.init],
        );

        if (checkInit.firstOrNull != null) {
          throw CreateException(
            message: 'Failed create location, init already exists',
          );
        }
      }

      if (params.code.isFilled()) {
        final checkCode = await db.query(
          'SELECT id FROM t_locations WHERE code = ? AND is_active = 1',
          [int.parse(params.code!)],
        );

        if (checkCode.firstOrNull != null) {
          throw CreateException(
            message: 'Failed create location, code already exists',
          );
        }
      }

      final response = await db.query(
        '''
      INSERT INTO t_locations (name, code, init, location_type, box_type, parent_id, is_storage, created_by)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      ''',
        [
          params.name?.toUpperCase(),
          params.code,
          params.init?.toUpperCase(),
          params.locationType?.toUpperCase(),
          params.boxType?.toUpperCase(),
          params.parentId,
          params.isStorage,
          userId,
        ],
      );

      if (response.insertId == null || response.insertId == 0) {
        throw CreateException(
          message: 'Failed to create location, please try again',
        );
      }

      final newLocation = await db.query(
        '''
      SELECT
        c.id AS id,
        c.name AS name,
        c.code AS code,
        c.init AS init,
        c.location_type AS location_type,
        c.box_type AS box_type,
        c.parent_id AS parent_id,
        p.name AS parent_name,
        c.is_storage AS is_storage
      FROM
        t_locations AS c
      LEFT JOIN
        t_locations AS P ON c.parent_id = p.id
      WHERE c.id = ?
      ''',
        [response.insertId],
      );

      return LocationModel.fromDatabase(newLocation.first.fields);
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
  Future<List<LocationModel>> findAllLocation() async {
    try {
      final db = await _database.connection;

      final locations = await db.query(
        '''
      SELECT
        c.id AS id,
        c.name AS name,
        c.code AS code,
        c.init AS init,
        c.location_type AS location_type,
        c.box_type AS box_type,
        c.parent_id AS parent_id,
        p.name AS parent_name,
        c.is_storage AS is_storage
      FROM
        t_locations AS c
      LEFT JOIN
        t_locations AS P ON c.parent_id = p.id
      WHERE c.is_active = 1
      ORDER BY c.name ASC
      ''',
      );

      if (locations.firstOrNull == null || locations.firstOrNull!.isEmpty) {
        throw NotFoundException(message: 'Location still is empty');
      }

      return locations
          .map((e) => LocationModel.fromDatabase(e.fields))
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
  Future<LocationModel> findByIdLocation(int params) async {
    try {
      final db = await _database.connection;

      final locations = await db.query(
        '''
      SELECT
        c.id AS id,
        c.name AS name,
        c.code AS code,
        c.init AS init,
        c.location_type AS location_type,
        c.box_type AS box_type,
        c.parent_id AS parent_id,
        p.name AS parent_name,
        c.is_storage AS is_storage
      FROM
        t_locations AS c
      LEFT JOIN
        t_locations AS P ON c.parent_id = p.id
      WHERE c.id = ? AND c.is_active = 1
      ''',
        [params],
      );

      if (locations.firstOrNull == null || locations.firstOrNull!.isEmpty) {
        throw NotFoundException(message: 'Location not found');
      }

      return LocationModel.fromDatabase(locations.first.fields);
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
  Future<LocationModel> updateLocation(LocationModel params) async {
    try {
      final db = await _database.connection;

      await db.query(
        '''
      UPDATE t_locations
      SET name = ?
      WHERE id = ?
      ''',
        [params.name!.toUpperCase(), params.id],
      );

      final locations = await db.query(
        '''
      SELECT
        c.id AS id,
        c.name AS name,
        c.code AS code,
        c.init AS init,
        c.location_type AS location_type,
        c.box_type AS box_type,
        c.parent_id AS parent_id,
        p.name AS parent_name,
        c.is_storage AS is_storage
      FROM
        t_locations AS c
      LEFT JOIN
        t_locations AS P ON c.parent_id = p.id
      WHERE c.id = ?
      ''',
        [params.id],
      );

      return LocationModel.fromDatabase(locations.first.fields);
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

  @override
  Future<List<LocationModel>> findLocationByQuery(String query) async {
    try {
      final db = await _database.connection;

      var whereClause = '';
      final pattern = '%${query.trim()}%';

      whereClause = '''
        WHERE 
          (c.name LIKE ? OR c.init LIKE ?) 
          AND c.is_active = ?
        ''';

      final response = await db.query(
        '''
        SELECT
          c.id AS id,
          c.name AS name,
          c.code AS code,
          c.init AS init,
          c.location_type AS location_type,
          c.box_type AS box_type,
          c.parent_id AS parent_id,
          p.name AS parent_name,
          c.is_storage AS is_storage
        FROM
          t_locations AS c
        LEFT JOIN
          t_locations AS P ON c.parent_id = p.id
        $whereClause
        ORDER BY c.name ASC
        ''',
        [pattern, pattern, 1],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Location Not Found Record');
      } else {
        return response
            .map((e) => LocationModel.fromDatabase(e.fields))
            .toList();
      }
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
  Future<List<LocationModel>> findLocationNonStorage() async {
    try {
      final db = await _database.connection;

      final locations = await db.query(
        '''
      SELECT
        c.id AS id,
        c.name AS name,
        c.code AS code,
        c.init AS init,
        c.location_type AS location_type,
        c.box_type AS box_type,
        c.parent_id AS parent_id,
        p.name AS parent_name,
        c.is_storage AS is_storage
      FROM
        t_locations AS c
      LEFT JOIN
        t_locations AS P ON c.parent_id = p.id
      WHERE c.is_active = 1 AND c.is_storage = 0
      ORDER BY c.name ASC
      ''',
      );

      if (locations.firstOrNull == null || locations.firstOrNull!.isEmpty) {
        throw NotFoundException(message: 'Location still is empty');
      }

      return locations
          .map((e) => LocationModel.fromDatabase(e.fields))
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
  Future<List<LocationModel>> findLocationStorage() async {
    try {
      final db = await _database.connection;

      final locations = await db.query(
        '''
      SELECT
        c.id AS id,
        c.name AS name,
        c.code AS code,
        c.init AS init,
        c.location_type AS location_type,
        c.box_type AS box_type,
        c.parent_id AS parent_id,
        p.name AS parent_name,
        c.is_storage AS is_storage
      FROM
        t_locations AS c
      LEFT JOIN
        t_locations AS P ON c.parent_id = p.id
      WHERE c.is_active = 1 AND c.is_storage = 1
      ORDER BY c.name ASC
      ''',
      );

      if (locations.firstOrNull == null || locations.firstOrNull!.isEmpty) {
        throw NotFoundException(message: 'Location still is empty');
      }

      return locations
          .map((e) => LocationModel.fromDatabase(e.fields))
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
  Future<List<String>> findAllLocationType() async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        'SELECT DISTINCT location_type FROM t_locations',
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Location type not record found');
      }

      return response.map((e) => e.fields['location_type'] as String).toList();
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
  Future<String> deleteLocation({
    required int id,
    required int userId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final responseLocation = await txn.query(
          'SELECT * FROM t_locations WHERE id = ?',
          [id],
        );

        final location = responseLocation.first.fields;

        final checkIsAssetAlreadyInLocation = await txn.query(
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
          WHERE l1.id = ? OR l2.id = ?
          ''',
          [id, id],
        );

        if (checkIsAssetAlreadyInLocation.firstOrNull != null) {
          throw DeleteException(
            message:
                'Failed delete location ${location['name']}, there are still assets at that location',
          );
        }

        final response = await txn.query(
          '''
          UPDATE t_locations
          SET is_active = 0, updated_by = ?
          WHERE id = ?
          ''',
          [userId, id],
        );

        if (response.affectedRows == null) {
          throw DeleteException(
            message:
                'Failed delete location ${location['name']}, please try again',
          );
        }

        return 'Successfully delete location ${location['name']}';
      });

      return response!;
    } on DeleteException {
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
  Future<LocationPaginationModel> findLocationByPagination({
    required int page,
    required int limit,
    String? query,
  }) async {
    if (query.isFilled()) {
      return await _PaginationWithQuery(page, limit, query!);
    } else {
      return await _PaginationWithoutQuery(page, limit);
    }
  }

  Future<LocationPaginationModel> _PaginationWithQuery(
    int page,
    int limit,
    String query,
  ) async {
    try {
      final db = await _database.connection;
      final offset = (page - 1) * limit;

      var whereClause = 'WHERE c.is_active = 1';
      var queryArgs = <dynamic>[];

      if (query.trim().isNotEmpty) {
        final pattern = '%${query.trim()}%';
        whereClause += ' AND (c.name LIKE ? OR c.init LIKE ?)';
        queryArgs = [pattern, pattern];
      }

      final totalResponse = await db.query(
        '''
      SELECT COUNT(*) AS total 
      FROM t_locations AS c
      $whereClause
      ''',
        queryArgs,
      );

      final totalData = totalResponse.first.fields['total'] as int? ?? 0;

      final dataArgs = [...queryArgs, limit, offset];
      final response = await db.query(
        '''
      SELECT
        c.id AS id,
        c.name AS name,
        c.code AS code,
        c.init AS init,
        c.location_type AS location_type,
        c.box_type AS box_type,
        c.parent_id AS parent_id,
        p.name AS parent_name,
        c.is_storage AS is_storage
      FROM
        t_locations AS c
      LEFT JOIN
        t_locations AS p ON c.parent_id = p.id
      $whereClause
      ORDER BY c.name ASC
      LIMIT ? OFFSET ?
      ''',
        dataArgs,
      );

      final data =
          // ignore: inference_failure_on_collection_literal
          response.isEmpty ? [] : response.map((e) => e.fields).toList();

      final result = {
        'total_data': totalData,
        'current_page': page,
        'last_page': totalData > 0 ? (totalData / limit).ceil() : 1,
        'limit': limit,
        'data': data,
      };

      return LocationPaginationModel.fromDatabase(result);
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

  Future<LocationPaginationModel> _PaginationWithoutQuery(
    int page,
    int limit,
  ) async {
    try {
      final db = await _database.connection;

      final offset = (page - 1) * limit;

      final response = await db.query(
        '''
      SELECT
        c.id AS id,
        c.name AS name,
        c.code AS code,
        c.init AS init,
        c.location_type AS location_type,
        c.box_type AS box_type,
        c.parent_id AS parent_id,
        p.name AS parent_name,
        c.is_storage AS is_storage
      FROM
        t_locations AS c
      LEFT JOIN
        t_locations AS P ON c.parent_id = p.id
      WHERE c.is_active = ?
      ORDER BY c.name ASC
      LIMIT ? OFFSET ?
      ''',
        [1, limit, offset],
      );

      final responseTotalData = await db.query(
        'SELECT COUNT(*) AS total FROM t_locations WHERE is_active = 1',
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

      return LocationPaginationModel.fromDatabase(datas);
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
}
