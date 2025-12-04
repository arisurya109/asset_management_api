// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_item/domain/entities/preparation_item.dart';
import 'package:asset_management_api/features/preparation_item/domain/repositories/preparation_item_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePreparationItemUseCase {
  CreatePreparationItemUseCase(this._repository);

  final PreparationItemRepository _repository;

  Future<Either<Failure, PreparationItem>> call({
    required PreparationItem params,
  }) async {
    return _repository.createPreparationItem(params: params);
  }
}
