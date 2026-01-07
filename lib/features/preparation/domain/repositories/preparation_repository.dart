// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_pagination.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationRepository {
  Future<Either<Failure, List<String>>> getPreparationTypes();
  Future<Either<Failure, Preparation>> createPreparation({
    required Preparation params,
  });
  Future<Either<Failure, PreparationPagination>> findPreparationByPagination({
    required int page,
    required int limit,
    String? query,
  });
  Future<Either<Failure, Preparation>> updatePreparationStatus({
    required int id,
    required String params,
    required int userId,
    int? totalBox,
    int? temporaryLocationId,
  });
}
