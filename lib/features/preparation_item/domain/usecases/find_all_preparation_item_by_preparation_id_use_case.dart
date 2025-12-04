// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_item/domain/entities/preparation_item.dart';
import 'package:asset_management_api/features/preparation_item/domain/repositories/preparation_item_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationItemByPreparationIdUseCase {
  FindAllPreparationItemByPreparationIdUseCase(this._repository);

  final PreparationItemRepository _repository;

  Future<Either<Failure, List<PreparationItem>>> call({
    required int preparationId,
  }) async {
    return _repository.findAllPreparationItemByPreparationId(
      preparationId: preparationId,
    );
  }
}
