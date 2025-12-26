// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:dartz/dartz.dart';

class DeleteLocationByIdUseCase {
  DeleteLocationByIdUseCase(this._repository);

  final LocationRepository _repository;

  Future<Either<Failure, void>> call(int params) async {
    return _repository.deleteLocationById(params);
  }
}
