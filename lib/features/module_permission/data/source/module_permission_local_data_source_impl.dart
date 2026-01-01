// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/module_permission/data/model/module_permission_model.dart';
import 'package:asset_management_api/features/module_permission/data/source/module_permission_local_data_source.dart';

class ModulePermissionLocalDataSourceImpl
    implements ModulePermissionLocalDataSource {
  ModulePermissionLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<List<ModulePermissionModel>> findAllModulePermission() async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
        mp.id AS id,
        m.module_name AS module, 
        p.permission_name AS permission
      FROM
        t_module_permission AS mp
      LEFT JOIN t_modules AS m ON mp.module_id = m.id
      LEFT JOIN t_permissions AS p ON mp.permission_id = p.id
      ''',
    );

    return ModulePermissionModel.transformFromDatabase(
      response.map((e) => e.fields).toList(),
    );
  }

  @override
  Future<ModulePermissionModel> findModulePermissionById(int params) async {
    final db = await _database.connection;

    // 1. Ambil data baris tersebut untuk tahu ini modul apa
    final query = await db.query(
      '''
      SELECT
        m.module_name AS module,
        mp.id AS id,
        p.permission_name AS permission
      FROM
        t_module_permission AS mp
      LEFT JOIN t_modules AS m ON mp.module_id = m.id
      LEFT JOIN t_permissions AS p ON mp.permission_id = p.id
      WHERE m.id = (SELECT module_id FROM t_module_permission WHERE id = ?)
    ''',
      [params],
    );

    if (query.isEmpty) throw NotFoundException(message: 'Not found record');

    final list = ModulePermissionModel.transformFromDatabase(
      query.map((e) => e.fields).toList(),
    );

    return list.first;
  }
}
