// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/domain/entities/location.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindDestinationInternalUseCase {
  FindDestinationInternalUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, List<Location>>> call() async {
    return _repository.findDestinationInternal();
  }
}
