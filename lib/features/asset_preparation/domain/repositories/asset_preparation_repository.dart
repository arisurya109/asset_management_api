// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_preparation/domain/entities/preparation_detail_request.dart';
import 'package:asset_management_api/features/asset_preparation/domain/entities/preparation_detail_response.dart';
import 'package:asset_management_api/features/asset_preparation/domain/entities/preparation_request.dart';
import 'package:asset_management_api/features/asset_preparation/domain/entities/preparation_response.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationRepository {
  Future<Either<Failure, PreparationResponse>> createPreparation(
    PreparationRequest params,
  );
  Future<Either<Failure, List<PreparationResponse>>> findAllPreparations();
  Future<Either<Failure, PreparationResponse>> updatePreparation(
    PreparationRequest params,
  );

  Future<Either<Failure, PreparationDetailResponse>> createPreparationDetail(
    PreparationDetailRequest params,
  );
  Future<Either<Failure, List<PreparationDetailResponse>>>
      findAllPreparationDetail(
    int params,
  );
}
