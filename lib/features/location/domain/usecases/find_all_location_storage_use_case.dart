// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:dartz/dartz.dart';

class FindAllLocationStorageUseCase {
  FindAllLocationStorageUseCase(this._repository);

  final LocationRepository _repository;

  Future<Either<Failure, List<Location>>> call() async {
    return _repository.findAllLocationStorage();
  }
}
