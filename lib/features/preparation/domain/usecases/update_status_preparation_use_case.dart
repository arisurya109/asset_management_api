// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStatusPreparationUseCase {
  UpdateStatusPreparationUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, Preparation>> call({
    required int id,
    required String status,
    required int userId,
    int? totalBox,
    int? locationId,
    String? remarks,
  }) async {
    return _repository.updateStatusPreparation(
      id: id,
      status: status,
      userId: userId,
      totalBox: totalBox,
      locationId: locationId,
      remarks: remarks,
    );
  }
}
