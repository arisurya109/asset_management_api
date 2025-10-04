// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_types/domain/entities/asset_type.dart';
import 'package:dartz/dartz.dart';

abstract class AssetTypeRepository {
  Future<Either<Failure, AssetType>> createAssetType(AssetType params);
  Future<Either<Failure, AssetType>> findAssetTypeById(int params);
  Future<Either<Failure, AssetType>> updateAssetType(AssetType params);
  Future<Either<Failure, List<AssetType>>> findAllAssetType();
  Future<Either<Failure, List<AssetType>>> findAssetTypeByIdBrand(int params);
}
