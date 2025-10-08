// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/locations/data/model/location_model.dart';
import 'package:asset_management_api/features/locations/data/source/location_local_data_source.dart';

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  LocationLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<LocationModel> createLocation(LocationModel params) async {
    final db = await _database.connection;

    final newLocation = await db.query('''
      INSERT INTO t_locations(area_id, location_code, location_name, location_init)
      VALUES (?, ?, ?, ?)
      ''', [
      params.areaId,
      params.locationCode,
      params.locationName,
      params.locationInit,
    ]);

    if (newLocation.insertId == 0 || newLocation.insertId == null) {
      throw CreateException(
        message: 'Failed to create new location, please try again',
      );
    }

    final responseLocation = await db.query(
      '''
      SELECT
        l.id AS id,
        l.location_code AS location_code,
        l.location_name AS location_name,
        l.location_init AS location_init,
        a.id AS area_id,
        a.area_name AS area_name,
        a.area_init AS area_init
      FROM
        t_locations AS l
      LEFT JOIN t_areas AS a ON l.area_id = a.id
      WHERE l.id = ?
      ''',
      [newLocation.insertId],
    );

    return LocationModel.fromDatabase(responseLocation.first.fields);
  }

  @override
  Future<List<LocationModel>> findAllLocation() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        l.id AS id,
        l.location_code AS location_code,
        l.location_name AS location_name,
        l.location_init AS location_init,
        a.id AS area_id,
        a.area_name AS area_name,
        a.area_init AS area_init
      FROM
        t_locations AS l
      LEFT JOIN t_areas AS a ON l.area_id = a.id
      ''',
    );

    if (response.firstOrNull == null || response.first.isEmpty) {
      throw NotFoundException(
        message: 'Location is empty, please create first location',
      );
    }

    return response.map((e) => LocationModel.fromDatabase(e.fields)).toList();
  }

  @override
  Future<LocationModel> findLocationById(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        l.id AS id,
        l.location_code AS location_code,
        l.location_name AS location_name,
        l.location_init AS location_init,
        a.id AS area_id,
        a.area_name AS area_name,
        a.area_init AS area_init
      FROM
        t_locations AS l
      LEFT JOIN t_areas AS a ON l.area_id = a.id
      WHERE l.id = ?
      ''',
      [params],
    );

    if (response.firstOrNull == null || response.first.isEmpty) {
      throw NotFoundException(message: 'Location not found');
    }

    return LocationModel.fromDatabase(response.first.fields);
  }

  @override
  Future<LocationModel> updateLocation(LocationModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkLocation = await txn.query(
        'SELECT COUNT(id) FROM t_locations WHERE id = ?',
        [params.id],
      );

      if (checkLocation.first.fields['COUNT(id)'] == 0) {
        throw UpdateException(message: 'Failed to update, location not found');
      }

      final updateLocation = await txn.query(
        '''
        UPDATE t_locations
        SET location_code = ?, location_name = ?, location_init = ?
        WHERE id = ?
        ''',
        [
          params.locationCode,
          params.locationName,
          params.locationInit,
          params.id,
        ],
      );

      if (updateLocation.affectedRows == 0 ||
          updateLocation.affectedRows == null) {
        throw UpdateException(
          message: 'Failed to update location, please try again',
        );
      }

      final newLocation = await txn.query(
        '''
      SELECT
        l.id AS id,
        l.location_code AS location_code,
        l.location_name AS location_name,
        l.location_init AS location_init,
        a.id AS area_id,
        a.area_name AS area_name,
        a.area_init AS area_init
      FROM
        t_locations AS l
      LEFT JOIN t_areas AS a ON l.area_id = a.id
      WHERE l.id = ?
      ''',
        [params.id],
      );

      return newLocation.first.fields;
    });

    return LocationModel.fromDatabase(response!);
  }
}
