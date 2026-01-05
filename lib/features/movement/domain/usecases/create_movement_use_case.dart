// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/movement/domain/entities/movement.dart';
import 'package:asset_management_api/features/movement/domain/repositories/movement_repository.dart';
import 'package:dartz/dartz.dart';

class CreateMovementUseCase {
  CreateMovementUseCase(this._repository);

  final MovementRepository _repository;

  Future<Either<Failure, String>> call({
    required Movement params,
    required int userId,
  }) async {
    return _repository.createMovement(
      userId: userId,
      params: params,
    );
  }
}
