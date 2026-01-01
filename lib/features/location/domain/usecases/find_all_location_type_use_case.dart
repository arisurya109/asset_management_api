// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllLocationTypeUseCase {
  FindAllLocationTypeUseCase(this._repository);

  final LocationRepository _repository;

  Future<Either<Failure, List<String>>> call() async {
    return _repository.findAllLocationType();
  }
}
