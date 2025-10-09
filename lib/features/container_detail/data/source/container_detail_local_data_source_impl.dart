// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/container_detail/data/model/container_detail_model.dart';
import 'package:asset_management_api/features/container_detail/data/source/container_detail_local_data_source.dart';

class ContainerDetailLocalDataSourceImpl
    implements ContainerDetailLocalDataSource {
  ContainerDetailLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<ContainerDetailModel> createContainerDetail(
    ContainerDetailModel params,
  ) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      INSERT INTO t_container_detail(container_id, container_detail_name)
      VALUES (?, ?)
      ''',
      [params.containerId, params.containerDetailName],
    );

    if (response.insertId == null || response.insertId == 0) {
      throw CreateException(
        message: 'Failed to create container detail, please try again',
      );
    }

    params.id = response.insertId;

    return params;
  }

  @override
  Future<List<ContainerDetailModel>> findAllContainerDetail() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        cd.id AS id,
        cd.container_detail_name AS container_detail_name,
        c.id AS container_id,
        c.container_name AS container_name
      FROM
        t_container_detail AS cd
      LEFT JOIN t_container AS c ON cd.container_id = c.id
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message:
            // ignore: lines_longer_than_80_chars
            'Failed to get all container detail, please create first container detail',
      );
    }

    return response
        .map((e) => ContainerDetailModel.fromDatabase(e.fields))
        .toList();
  }

  @override
  Future<ContainerDetailModel> updateContainerDetail(
    ContainerDetailModel params,
  ) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkId = await txn.query(
        'SELECT COUNT(id) FROM t_container_detail WHERE id = ?',
        [params.id],
      );

      if (checkId.first.fields['COUNT(id)'] == 0) {
        throw UpdateException(
          message:
              // ignore: lines_longer_than_80_chars
              'Failed to update container detail, container detail is not found',
        );
      }

      final updated = await txn.query(
        '''
        UPDATE t_container_detail
        SET container_detail_name = ?
        WHERE id = ?
        ''',
        [params.id],
      );

      if (updated.affectedRows == null || updated.affectedRows == 0) {
        throw UpdateException(
          message: 'Failed to update container detail, please try again',
        );
      }

      final newContainerDetail = await txn.query(
        '''
          SELECT
        cd.id AS id,
        cd.container_detail_name AS container_detail_name,
        c.id AS container_id,
        c.container_name AS container_name
      FROM
        t_container_detail AS cd
      LEFT JOIN t_container AS c ON cd.container_id = c.id
      WHERE c.id = ?
        ''',
        [params.id],
      );

      return newContainerDetail.first.fields;
    });

    return ContainerDetailModel.fromDatabase(response!);
  }
}
