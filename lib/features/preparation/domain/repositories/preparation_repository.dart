// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/domain/entities/location.dart';
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
  Future<Either<Failure, Preparation>> updateStatusPreparation({
    required int id,
    required String status,
    required int userId,
    int? totalBox,
    int? locationId,
    String? remarks,
  });
  Future<Either<Failure, List<Preparation>>>
      findPreparationByCodeOrDestination({
    required String params,
  });

  Future<Either<Failure, List<Location>>> findDestinationInternal();
  Future<Either<Failure, List<Location>>> findDestinationExternal();
}
