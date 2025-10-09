// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/container/data/model/container_model.dart';
import 'package:asset_management_api/features/container/data/source/container_local_data_source.dart';

class ContainerLocalDataSourceImpl implements ContainerLocalDataSource {
  ContainerLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<ContainerModel> createContainer(ContainerModel params) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      INSERT INTO t_container (location_detail_id, container_name)
      VALUES (?, ?)
      ''',
      [params.locationDetailId, params.containerName],
    );

    if (response.insertId == null || response.insertId == 0) {
      throw CreateException(
        message: 'Failed to create new container, please try again',
      );
    }

    final newContainer = await db.query(
      '''
      SELECT
        c.id AS id,
        c.container_name AS container_name,
        ld.location_detail_name AS location_detail_name,
        ld.id AS location_detail_id
      FROM
        t_container AS c
      WHERE
        c.id = ?
      ''',
      [response.insertId],
    );

    return ContainerModel.fromDatabase(newContainer.first.fields);
  }

  @override
  Future<List<ContainerModel>> findAllContainer() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        c.id AS id,
        c.container_name AS container_name,
        ld.location_detail_name AS location_detail_name,
        ld.id AS location_detail_id
      FROM
        t_container AS c
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Container is empty, please create first container',
      );
    }

    return response.map((e) => ContainerModel.fromDatabase(e.fields)).toList();
  }

  @override
  Future<ContainerModel> updateContainer(ContainerModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkLocationDetail = await txn.query(
        'SELECT COUNT(id) FROM t_container WHERE id = ?',
        [params.id],
      );

      if (checkLocationDetail.first.fields['COUNT(id)'] == 0) {
        throw UpdateException(
          message: 'Failed to update container, container is not found',
        );
      }

      final updateLocation = await txn.query(
        '''
        UPDATE t_container
        SET container_name = ?
        WHERE id = ?
        ''',
        [params.id],
      );

      if (updateLocation.affectedRows == null ||
          updateLocation.affectedRows == 0) {
        throw UpdateException(
          message: 'Failed to update container, please try again',
        );
      }

      final newContainer = await txn.query(
        '''
        SELECT
          c.id AS id,
          c.container_name AS container_name,
          ld.location_detail_name AS location_detail_name,
          ld.id AS location_detail_id
        FROM
          t_container AS c
        WHERE
        c.id = ?
        ''',
        [params.id],
      );

      return newContainer.first.fields;
    });

    return ContainerModel.fromDatabase(response!);
  }
}
