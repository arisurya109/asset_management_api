// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/module_permission/data/source/module_permission_local_data_source.dart';
import 'package:asset_management_api/features/module_permission/domain/entities/module_permission.dart';
import 'package:asset_management_api/features/module_permission/domain/repositories/module_permission_repository.dart';
import 'package:dartz/dartz.dart';

class ModulePermissionRepositoryImpl implements ModulePermissionRepository {
  ModulePermissionRepositoryImpl(this._source);

  final ModulePermissionLocalDataSource _source;

  @override
  Future<Either<Failure, List<ModulePermission>>>
      findAllModulePermission() async {
    try {
      final response = await _source.findAllModulePermission();
      print(response);
      return Right(response.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(NotFoundFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ModulePermission>> findModulePermissionById(
    int params,
  ) async {
    try {
      final response = await _source.findModulePermissionById(params);
      return Right(response.toEntity());
    } catch (e) {
      return Left(NotFoundFailure(e.toString()));
    }
  }
}
