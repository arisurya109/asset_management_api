// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/module_permission/data/model/module_permission_model.dart';

abstract class ModulePermissionLocalDataSource {
  Future<List<ModulePermissionModel>> findAllModulePermission();
  Future<ModulePermissionModel> findModulePermissionById(int params);
}
