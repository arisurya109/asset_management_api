// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/module_permission/domain/entities/module_permission.dart';
import 'package:dartz/dartz.dart';

abstract class ModulePermissionRepository {
  Future<Either<Failure, List<ModulePermission>>> findAllModulePermission();
  Future<Either<Failure, ModulePermission>> findModulePermissionById(
      int params);
}
