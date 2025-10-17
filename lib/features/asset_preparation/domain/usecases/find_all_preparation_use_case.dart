// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_preparation/domain/entities/preparation_response.dart';
import 'package:asset_management_api/features/asset_preparation/domain/repositories/asset_preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationUseCase {
  FindAllPreparationUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, List<PreparationResponse>>> call() async {
    return _repository.findAllPreparations();
  }
}
