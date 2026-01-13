// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_detail.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_detail_response.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_header.dart';
import 'package:dartz/dartz.dart';

abstract class PickingRepository {
  Future<Either<Failure, List<PickingHeader>>> findAllPickingTask({
    required int userId,
  });
  Future<Either<Failure, PickingDetailResponse>> findPickingDetail({
    required int id,
    required int userId,
  });
  Future<Either<Failure, String>> pickedAsset({
    required int userId,
    required PickingDetail params,
  });
}
