// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/module_permission/domain/entities/module_permission.dart';
import 'package:asset_management_api/features/module_permission/domain/repositories/module_permission_repository.dart';
import 'package:dartz/dartz.dart';

class FindModulePermissionByIdUseCase {
  FindModulePermissionByIdUseCase(this._repository);

  final ModulePermissionRepository _repository;

  Future<Either<Failure, ModulePermission>> call(int params) async {
    return _repository.findModulePermissionById(params);
  }
}
