// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_brand/domain/entities/asset_brand.dart';
import 'package:dartz/dartz.dart';

abstract class AssetBrandRepository {
  Future<Either<Failure, List<AssetBrand>>> findAllAssetBrand();
  Future<Either<Failure, AssetBrand>> findByIdAssetBrand(int params);
  Future<Either<Failure, AssetBrand>> createAssetBrand(AssetBrand params);
  Future<Either<Failure, AssetBrand>> updateAssetBrand(AssetBrand params);
  Future<Either<Failure, List<AssetBrand>>> findAssetBrandByQuery(
    String params,
  );
}
