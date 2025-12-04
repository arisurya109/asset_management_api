// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_detail/domain/entities/preparation_detail.dart';
import 'package:asset_management_api/features/preparation_detail/domain/repositories/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationDetailByPreparationIdUseCase {
  FindAllPreparationDetailByPreparationIdUseCase(this._repository);

  final PreparationDetailRepository _repository;

  Future<Either<Failure, List<PreparationDetail>>> call({
    required int preparationId,
  }) async {
    return _repository.findAllPreparationDetailByPreparationId(
      preparationId: preparationId,
    );
  }
}
