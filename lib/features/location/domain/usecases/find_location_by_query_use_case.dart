// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:dartz/dartz.dart';

class FindLocationByQueryUseCase {
  FindLocationByQueryUseCase(this._repository);

  final LocationRepository _repository;

  Future<Either<Failure, List<Location>>> call({required String params}) async {
    return _repository.findLocationByQuery(params: params);
  }
}
