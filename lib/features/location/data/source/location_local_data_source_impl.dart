// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
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
      INSERT INTO t_locations (name, code, init, location_type, box_type, parent_id)
      VALUES (?, ?, ?, ?, ?, ?)
      ''',
        [
          params.name?.toUpperCase(),
          params.code,
          params.init?.toUpperCase(),
          params.locationType?.toUpperCase(),
          params.boxType?.toUpperCase(),
          params.parentId,
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
        p.name AS parent_name
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
        p.name AS parent_name
      FROM
        t_locations AS c
      LEFT JOIN
        t_locations AS P ON c.parent_id = p.id
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
        p.name AS parent_name
      FROM
        t_locations AS c
      LEFT JOIN
        t_locations AS P ON c.parent_id = p.id
      WHERE c.id = ?
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
        p.name AS parent_name
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
}
