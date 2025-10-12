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

    final response = await db.query(
      'INSERT INTO t_locations (name) VALUES (?)',
      [params.name!.toUpperCase()],
    );

    params.id = response.insertId;

    return params;
  }

  @override
  Future<LocationBoxModel> createLocationBox(LocationBoxModel params) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      INSERT INTO t_location_boxs (name, location_rack_id, box_type)
      VALUES (?, ?, ?)
      ''',
      [
        params.name?.toUpperCase(),
        params.locationRackId,
        params.boxType?.toUpperCase(),
      ],
    );

    if (response.insertId == null || response.insertId == 0) {
      throw CreateException(
        message: 'Failed to create location box, please try again',
      );
    }

    final newLocationBox = await db.query(
      '''
      SELECT
        lb.id AS id,
        lb.name AS name,
        lb.box_type AS box_type,
        lk.id AS location_rack_id,
        lk.name AS location_rack_name
      FROM
        t_location_boxs AS lb
      LEFT JOIN
        t_location_racks AS lk
      ON
        lb.location_rack_id = lk.id
      WHERE
        lb.id = ? 
      ''',
      [response.insertId],
    );

    return LocationBoxModel.fromDatabase(newLocationBox.first.fields);
  }

  @override
  Future<LocationDetailModel> createLocationDetail(
    LocationDetailModel params,
  ) async {
    final db = await _database.connection;

    final response = await db.query('''
      INSERT INTO t_location_details (name, code, init, location_id)
      VALUES (?, ?, ?, ?)
      ''', [
      params.name?.toUpperCase(),
      params.code,
      params.init?.toUpperCase(),
      params.locationId,
    ]);

    if (response.insertId == null || response.insertId == 0) {
      throw CreateException(
        message: 'Failed to create location detail, please try again',
      );
    }

    final newLocationDetail = await db.query(
      '''
      SELECT
        ld.id AS id,
        ld.name AS name,
        ld.code AS code,
        ld.init AS init,
        l.id AS location_id,
        l.name AS location_name
      FROM
        t_locations_details AS ld
      LEFT JOIN
        t_locations AS l
      ON
        ld.location_id = l.id
      WHERE
        ld.id = ?
      ''',
      [response.insertId],
    );

    return LocationDetailModel.fromDatabase(newLocationDetail.first.fields);
  }

  @override
  Future<LocationRackModel> createLocationRack(
    LocationRackModel params,
  ) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      INSERT INTO t_location_racks (name, location_team_id)
      VALUES (?, ?)
      ''',
      [params.name?.toUpperCase(), params.locationTeamId],
    );

    if (response.insertId == null || response.insertId == 0) {
      throw CreateException(
        message: 'Failed to create location rack. please try again',
      );
    }

    final newLocationRack = await db.query(
      '''
      SELECT
        lr.id AS id,
        lr.name AS name,
        lt.id AS location_team_id,
        lt.name AS location_team_name
      FROM
        t_location_racks AS lr
      LEFT JOIN t_location_teams AS lt
      ON lr.location_team_id = lt.id
      WHERE id = ?
      ''',
      [response.insertId],
    );

    return LocationRackModel.fromDatabase(newLocationRack.first.fields);
  }

  @override
  Future<LocationTeamModel> createLocationTeam(
    LocationTeamModel params,
  ) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      INSERT INTO t_location_teams (name, location_detail_id)
      VALUES (?, ?)
      ''',
      [params.name?.toUpperCase(), params.locationDetailId],
    );

    if (response.insertId == null || response.insertId == 0) {
      throw CreateException(
        message: 'Failed to create location team, please try again',
      );
    }

    final newLocationTeam = await db.query(
      '''
      SELECT
        lt.id AS id,
        lt.name AS name,
        ld.id AS location_detail_id,
        ld.name AS location_detail_name
      FROM
        t_location_teams AS lt
      LEFT JOIN t_location_details AS ld
      ON lt.location_detail_id = ld.id
      WHERE lt.id = ?
      ''',
      [response.insertId],
    );

    return LocationTeamModel.fromDatabase(newLocationTeam.first.fields);
  }

  @override
  Future<List<LocationModel>> findAllLocation() async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_locations',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Location still empty, please insert first',
      );
    }

    return response.map((e) => LocationModel.fromDatabase(e.fields)).toList();
  }

  @override
  Future<List<LocationBoxModel>> findAllLocationBox() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        lb.id AS id,
        lb.name AS name,
        lb.box_type AS box_type,
        lr.id AS location_rack_id,
        lr.name AS location_rack_name
      FROM
        t_location_boxs AS lb
      LEFT JOIN t_location_racks AS lr
      ON lb.location_rack_id = lr.id
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Location Box still empty, please insert first',
      );
    }

    return response
        .map((e) => LocationBoxModel.fromDatabase(e.fields))
        .toList();
  }

  @override
  Future<List<LocationDetailModel>> findAllLocationDetail() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        ld.id AS id,
        ld.name AS name,
        ld.code AS code,
        ld.init AS init,
        l.id AS location_id,
        l.name AS location_name
      FROM
        t_location_details AS ld
      LEFT JOIN t_locations AS l
      ON ld.location_id = l.id
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Location Detail still empty, please insert first',
      );
    }

    return response
        .map((e) => LocationDetailModel.fromDatabase(e.fields))
        .toList();
  }

  @override
  Future<List<LocationRackModel>> findAllLocationRack() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        lr.id AS id,
        lr.name AS name,
        lt.id AS location_team_id,
        lt.name AS location_team_name
      FROM
        t_location_racks AS lr
      LEFT JOIN t_location_teams AS lt
      ON lr.location_team_id = lt.id
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Location Detail still empty, please insert first',
      );
    }

    return response
        .map((e) => LocationRackModel.fromDatabase(e.fields))
        .toList();
  }

  @override
  Future<List<LocationTeamModel>> findAllLocationTeam() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        lt.id AS id,
        lt.name AS name,
        ld.id AS location_detail_id,
        ld.name AS location_detail_name
      FROM
        t_location_teams AS lt
      LEFT JOIN t_location_details AS ld
      ON lt.location_detail_id = ld.id
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Location Team still empty, please insert first',
      );
    }

    return response
        .map((e) => LocationTeamModel.fromDatabase(e.fields))
        .toList();
  }

  @override
  Future<LocationModel> findByIdLocation(int params) {
    // TODO: implement findByIdLocation
    throw UnimplementedError();
  }

  @override
  Future<LocationBoxModel> findByIdLocationBox(int params) {
    // TODO: implement findByIdLocationBox
    throw UnimplementedError();
  }

  @override
  Future<LocationDetailModel> findByIdLocationDetail(int params) {
    // TODO: implement findByIdLocationDetail
    throw UnimplementedError();
  }

  @override
  Future<LocationRackModel> findByIdLocationRack(int params) {
    // TODO: implement findByIdLocationRack
    throw UnimplementedError();
  }

  @override
  Future<LocationTeamModel> findByIdLocationTeam(int params) {
    // TODO: implement findByIdLocationTeam
    throw UnimplementedError();
  }

  @override
  Future<LocationModel> updateLocation(LocationModel params) {
    // TODO: implement updateLocation
    throw UnimplementedError();
  }

  @override
  Future<LocationBoxModel> updateLocationBox(LocationBoxModel params) {
    // TODO: implement updateLocationBox
    throw UnimplementedError();
  }

  @override
  Future<LocationDetailModel> updateLocationDetail(LocationDetailModel params) {
    // TODO: implement updateLocationDetail
    throw UnimplementedError();
  }

  @override
  Future<LocationRackModel> updateLocationRack(LocationRackModel params) {
    // TODO: implement updateLocationRack
    throw UnimplementedError();
  }

  @override
  Future<LocationTeamModel> updateLocationTeam(LocationTeamModel params) {
    // TODO: implement updateLocationTeam
    throw UnimplementedError();
  }
}
