// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_detail/domain/entities/preparation_detail.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationDetailRepository {
  Future<Either<Failure, List<PreparationDetail>>>
      findAllPreparationDetailByPreparationId({
    required int preparationId,
  });

  Future<Either<Failure, PreparationDetail>> findPreparationDetailById({
    required int id,
  });

  Future<Either<Failure, PreparationDetail>> createPreparationDetail({
    required PreparationDetail params,
  });

  Future<Either<Failure, PreparationDetail>> updatePreparationDetail({
    required PreparationDetail params,
  });

  Future<Either<Failure, PreparationDetail>>
      updateStatusProgressPreparationDetail({
    required int id,
    required int userId,
  });

  Future<Either<Failure, PreparationDetail>>
      updateStatusCompletedPreparationDetail({
    required int id,
    required int userId,
  });
}
