// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class CompletedPreparationUseCase {
  CompletedPreparationUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, Preparation>> call(
    Preparation params,
    List<int> fileBytes,
    String originalName,
  ) async {
    return _repository.completedPreparation(params, fileBytes, originalName);
  }
}
