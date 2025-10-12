// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/locations/domain/entities/location.dart';
import 'package:asset_management_api/features/locations/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class FindByIdLocationDetailUseCase {
  FindByIdLocationDetailUseCase(this._repository);

  final LocationRepository _repository;

  Future<Either<Failure, LocationDetail>> call(int params) async {
    return _repository.findByIdLocationDetail(params);
  }
}
