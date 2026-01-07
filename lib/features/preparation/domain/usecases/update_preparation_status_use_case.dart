// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePreparationStatusUseCase {
  UpdatePreparationStatusUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, Preparation>> call({
    required int id,
    required String params,
    required int userId,
    int? totalBox,
    int? temporaryLocationId,
  }) async {
    return _repository.updatePreparationStatus(
      id: id,
      params: params,
      userId: userId,
      temporaryLocationId: temporaryLocationId,
      totalBox: totalBox,
    );
  }
}
