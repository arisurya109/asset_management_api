// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/location_detail/data/model/location_detail_model.dart';
import 'package:asset_management_api/features/location_detail/data/source/location_detail_local_data_source.dart';

class LocationDetailLocalDataSourceImpl
    implements LocationDetailLocalDataSource {
  LocationDetailLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<LocationDetailModel> createLocationDetail(
    LocationDetailModel params,
  ) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      INSERT INTO t_location_detail (location_id, location_detail_name)
      VALUES (?, ?)
      ''',
      [params.locationId, params.locationDetailName],
    );

    if (response.insertId == null || response.insertId == 0) {
      throw CreateException(
        message: 'Failed to create location detail, please try again',
      );
    }

    final newLocationDetail = await db.query(
      '''
      SELECT
        ld.id AS id,
        ld.location_detail_name AS location_detail_name,
        l.id AS location_id,
        l.location_code AS location_code,
        l.location_name AS location_name,
      FROM
        t_location_detail AS ld
      LEFT JOIN t_locations AS l ON ld.location_id = l.id
      WHERE l.id = ?
      ''',
      [response.insertId],
    );

    return LocationDetailModel.fromDatabase(newLocationDetail.first.fields);
  }

  @override
  Future<List<LocationDetailModel>> findAllLocationDetail() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        ld.id AS id,
        ld.location_detail_name AS location_detail_name,
        l.id AS location_id,
        l.location_code AS location_code,
        l.location_name AS location_name,
      FROM
        t_location_detail AS ld
      LEFT JOIN t_locations AS l ON ld.location_id = l.id
      ''',
    );

    if (response.firstOrNull == null || response.first.isEmpty) {
      throw NotFoundException(message: 'Location detail not found');
    }

    return response
        .map((e) => LocationDetailModel.fromDatabase(e.fields))
        .toList();
  }

  @override
  Future<LocationDetailModel> updateLocationDetail(
    LocationDetailModel params,
  ) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkLocationDetail = await txn.query(
        'SELECT COUNT(id) FROM t_location_detail WHERE id = ?',
        [params.locationId],
      );

      if (checkLocationDetail.first.fields['COUNT(id)'] == 0) {
        throw UpdateException(
          message: 'Failed to update location detail, location is not found',
        );
      }

      final updateLocation = await txn.query(
        '''
        UPDATE t_location_detail
        SET location_name = ?
        WHERE id = ?
        ''',
        [params.locationId],
      );

      if (updateLocation.affectedRows == null ||
          updateLocation.affectedRows == 0) {
        throw UpdateException(
          message: 'Failed to update location, please try again',
        );
      }

      final newLocation = await txn.query(
        '''
        SELECT
          ld.id AS id,
          ld.location_detail_name AS location_detail_name,
          l.id AS location_id,
          l.location_code AS location_code,
          l.location_name AS location_name,
        FROM
          t_location_detail AS ld
        LEFT JOIN t_locations AS l ON ld.location_id = l.id
        WHERE l.id = ?
        ''',
        [params.id],
      );

      return newLocation.first.fields;
    });

    return LocationDetailModel.fromDatabase(response!);
  }
}
