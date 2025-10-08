// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/areas/data/model/area_model.dart';
import 'package:asset_management_api/features/areas/data/source/area_local_data_source.dart';

class AreaLocalDataSourceImpl implements AreaLocalDataSource {
  AreaLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<List<AreaModel>> findAllArea() async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_areas',
    );

    if (response.firstOrNull == null || response.first.isEmpty) {
      throw NotFoundException(message: 'Area is empty');
    }

    return response.map((e) => AreaModel.fromDatabase(e.fields)).toList();
  }

  @override
  Future<AreaModel> findAreaById(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_areas WHERE id = ?',
    );

    if (response.firstOrNull == null || response.first.isEmpty) {
      throw NotFoundException(message: 'Area not found');
    }

    return AreaModel.fromDatabase(response.first.fields);
  }
}
