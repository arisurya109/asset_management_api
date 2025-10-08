// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location_detail/domain/entities/location_detail.dart';
import 'package:asset_management_api/features/location_detail/domain/repositories/location_detail%20_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateLocationDetalUseCase {
  UpdateLocationDetalUseCase(this._repository);

  final LocationDetailRepository _repository;

  Future<Either<Failure, LocationDetail>> call(LocationDetail params) async {
    return _repository.updateLocationDetail(params);
  }
}
