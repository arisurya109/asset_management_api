// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/domain/entities/asset.dart';
import 'package:dartz/dartz.dart';

abstract class AssetRepository {
  Future<Either<Failure, List<Asset>>> findAllAsset();
  Future<Either<Failure, Asset>> createAsset(Asset params);
  Future<Either<Failure, Asset>> updateAsset(Asset params);
  Future<Either<Failure, Asset>> findAssetById(int id);
}
