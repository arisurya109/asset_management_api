// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_item/domain/entities/preparation_item.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationItemRepository {
  Future<Either<Failure, List<PreparationItem>>>
      findAllPreparationItemByPreparationId({
    required int preparationId,
  });
  Future<Either<Failure, List<PreparationItem>>>
      findAllPreparationItemByPreparationDetailId({
    required int preparationDetailId,
  });
  Future<Either<Failure, PreparationItem>> createPreparationItem({
    required PreparationItem params,
  });
  Future<Either<Failure, String>> deletePreparationItem({
    required int id,
  });
}
