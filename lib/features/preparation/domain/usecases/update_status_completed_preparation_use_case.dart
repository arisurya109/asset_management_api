// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStatusCompletedPreparationUseCase {
  UpdateStatusCompletedPreparationUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, Preparation>> call({
    required int id,
    required int userId,
    required List<int> fileBytes,
    required String originalName,
  }) async {
    return _repository.updateStatusCompletedPreparation(
      id: id,
      userId: userId,
      fileBytes: fileBytes,
      originalName: originalName,
    );
  }
}
