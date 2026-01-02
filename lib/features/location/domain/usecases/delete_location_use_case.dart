// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteLocationUseCase {
  DeleteLocationUseCase(this._repository);

  final LocationRepository _repository;

  Future<Either<Failure, String>> call({
    required int id,
    required int userId,
  }) async {
    return _repository.deleteLocation(
      id: id,
      userId: userId,
    );
  }
}
