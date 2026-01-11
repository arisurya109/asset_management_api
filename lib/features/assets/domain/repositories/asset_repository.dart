// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/domain/entities/asset_detail_response.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_request.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_response.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_response_pagination.dart';
import 'package:dartz/dartz.dart';

abstract class AssetsRepository {
  Future<Either<Failure, List<AssetsResponse>>> findAllAssets();
  Future<Either<Failure, AssetsResponse>> registrationAsset(
    AssetsRequest params,
  );
  Future<Either<Failure, AssetsResponse>> migrationAsset(AssetsRequest params);
  Future<Either<Failure, AssetDetailResponse>> findAssetDetailById(int params);
  Future<Either<Failure, List<AssetsResponse>>> findAssetByQuery({
    required String params,
  });
  Future<Either<Failure, AssetsResponsePagination>> findAssetByPagination({
    required int page,
    required int limit,
    String? query,
  });
}
