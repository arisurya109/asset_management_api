// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/features/module_permission/data/model/module_permission_model.dart';
import 'package:asset_management_api/features/module_permission/data/source/module_permission_local_data_source.dart';

class ModulePermissionLocalDataSourceImpl
    implements ModulePermissionLocalDataSource {
  ModulePermissionLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<List<ModulePermissionModel>> findAllModulePermission() async {
    final db = await _database.connection;

    final query = await db.query(
      '''
      SELECT
        mp.id AS id,
        CONCAT(m.module_name, '_', p.permission_name) AS module_permission_name,
        CONCAT(m.module_label, '_', p.permission_label) AS module_permission_label
      FROM
        t_module_permission AS mp
      LEFT JOIN t_modules AS m ON mp.module_id = m.id
      LEFT JOIN t_permissions AS p ON mp.permission_id = p.id
      ''',
    );

    return query
        .map((e) => ModulePermissionModel.fromDatabase(e.fields))
        .toList();
  }

  @override
  Future<ModulePermissionModel> findModulePermissionById(int params) async {
    final db = await _database.connection;

    final query = await db.query(
      '''
      SELECT
        mp.id AS id,
        CONCAT(m.module_name, '_', p.permission_name) AS module_permission_name,
        CONCAT(m.module_label, '_', p.permission_label) AS module_permission_label
      FROM
        t_module_permission AS mp
      LEFT JOIN t_modules AS m ON mp.module_id = m.id
      LEFT JOIN t_permissions AS p ON mp.permission_id = p.id
      WHERE mp.id = ?
      ''',
      [params],
    );

    return ModulePermissionModel.fromDatabase(query.first.fields);
  }
}
