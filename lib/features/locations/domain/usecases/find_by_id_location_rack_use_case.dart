// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/locations/domain/entities/location.dart';
import 'package:asset_management_api/features/locations/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class FindByIdLocationRackUseCase {
  FindByIdLocationRackUseCase(this._repository);

  final LocationRepository _repository;

  Future<Either<Failure, LocationRack>> call(int params) async {
    return _repository.findByIdLocationRack(params);
  }
}
