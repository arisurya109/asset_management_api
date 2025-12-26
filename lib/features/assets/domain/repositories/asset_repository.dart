// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_detail.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_request.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_response.dart';
import 'package:dartz/dartz.dart';

abstract class AssetsRepository {
  Future<Either<Failure, List<AssetsResponse>>> findAllAssets();
  Future<Either<Failure, AssetsResponse>> createAssets(AssetsRequest params);
  Future<Either<Failure, List<AssetsDetail>>> findAssetDetailById(int params);
  Future<Either<Failure, AssetsResponse>> createAssetTransfer({
    required int movementById,
    required int assetId,
    required String movementType,
    required int fromLocationId,
    required int toLocationId,
    int quantity = 1,
    String? notes,
  });
  Future<Either<Failure, AssetsResponse>> findAssetByAssetCodeAndLocation({
    required String assetCode,
    required String location,
  });
  Future<Either<Failure, List<AssetsResponse>>> findAssetByQuery({
    required String params,
  });
}
