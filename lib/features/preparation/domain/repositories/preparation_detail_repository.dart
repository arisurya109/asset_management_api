// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail_response.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationDetailRepository {
  Future<Either<Failure, PreparationDetailResponse>> getPreparationDetails({
    required int preparationId,
  });
  Future<Either<Failure, String>> addPreparationDetail({
    required PreparationDetail params,
    required int userId,
  });
}
