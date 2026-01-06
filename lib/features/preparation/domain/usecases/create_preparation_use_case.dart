import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePreparationUseCase {
  CreatePreparationUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, Preparation>> call({
    required Preparation params,
  }) async {
    return _repository.createPreparation(params: params);
  }
}
