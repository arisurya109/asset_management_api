// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_categories/domain/entities/asset_category.dart';
import 'package:dartz/dartz.dart';

abstract class AssetCategoryRepository {
  Future<Either<Failure, List<AssetCategory>>> findAllAssetCategory();
  Future<Either<Failure, AssetCategory>> createCategory(AssetCategory params);
  Future<Either<Failure, AssetCategory>> updateCategory(AssetCategory params);
  Future<Either<Failure, AssetCategory>> findByIdAssetCategory(
    int params,
  );
}
