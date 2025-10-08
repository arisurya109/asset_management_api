// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location_detail/domain/entities/location_detail.dart';
import 'package:asset_management_api/features/location_detail/domain/repositories/location_detail%20_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllLocationDetailUseCase {
  FindAllLocationDetailUseCase(this._repository);

  final LocationDetailRepository _repository;

  Future<Either<Failure, List<LocationDetail>>> call() async {
    return _repository.findAllLocationDetail();
  }
}
