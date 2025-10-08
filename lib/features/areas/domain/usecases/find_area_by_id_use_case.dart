// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/areas/domain/entities/area.dart';
import 'package:asset_management_api/features/areas/domain/repositories/area_repository.dart';
import 'package:dartz/dartz.dart';

class FindAreaByIdUseCase {
  FindAreaByIdUseCase(this._repository);

  final AreaRepository _repository;

  Future<Either<Failure, Area>> call(int params) async {
    return _repository.findAreaById(params);
  }
}
