// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_item/domain/repositories/preparation_item_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePreparationItemUseCase {
  DeletePreparationItemUseCase(this._repository);

  final PreparationItemRepository _repository;

  Future<Either<Failure, String>> call({
    required int id,
  }) async {
    return _repository.deletePreparationItem(
      id: id,
    );
  }
}
