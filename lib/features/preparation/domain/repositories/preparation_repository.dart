// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationRepository {
  Future<Either<Failure, List<Preparation>>> findAllPreparation();
  Future<Either<Failure, Preparation>> findPreparationById({
    required int params,
  });
  Future<Either<Failure, Preparation>> createPreparation({
    required Preparation params,
  });
  Future<Either<Failure, Preparation>> updateStatusAssignedPreparation({
    required int id,
    required int userId,
  });
  Future<Either<Failure, Preparation>> updateStatusPickingPreparation({
    required int id,
    required int userId,
  });
  Future<Either<Failure, Preparation>> updateStatusReadyPreparation({
    required int id,
    required int userId,
    required int locationId,
    required int totalBox,
  });
  Future<Either<Failure, Preparation>> updateStatusApprovedPreparation({
    required int id,
    required int userId,
  });
  Future<Either<Failure, Preparation>> updateStatusCompletedPreparation({
    required int id,
    required int userId,
    required List<int> fileBytes,
    required String originalName,
  });
  Future<Either<Failure, Preparation>> updateStatusCancelledPreparation({
    required int id,
    required int userId,
  });
}
