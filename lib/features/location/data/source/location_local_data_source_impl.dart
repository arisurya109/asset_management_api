// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/features/location/data/model/location_model.dart';
import 'package:asset_management_api/features/location/data/source/location_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  LocationLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<LocationModel> createLocation(LocationModel params) async {
    try {
      final db = await _database.connection;

      final checkName = await db.query(
        'SELECT id FROM t_locations WHERE name = ?',
        [params.name],
      );

      if (checkName.firstOrNull != null) {
        throw CreateException(
          message: 'Failed create location, name already exists',
        );
      }

      final response = await db.query(
        '''
      INSERT INTO t_locations (name, code, init, location_type, box_type, parent_id, is_storage)
      VALUES (?, ?, ?, ?, ?, ?, ?)
      ''',
        [
          params.name?.toUpperCase(),
          params.code,
          params.init?.toUpperCase(),
          params.locationType?.toUpperCase(),
          params.boxType?.toUpperCase(),
          params.parentId,
          params.isStorage,
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
      var queryArgs = <dynamic>[];

      if (query.trim().isFilled()) {
        final pattern = '%${query.trim()}%';

        whereClause = '''
        WHERE 
          c.name LIKE ? OR 
          c.init LIKE ? AND
          c.is_active = 1
        ''';

        queryArgs = List.filled(2, pattern);
      }

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
        ''',
        queryArgs,
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
}
