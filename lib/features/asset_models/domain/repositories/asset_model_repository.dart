// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_models/domain/entities/asset_model.dart';
import 'package:dartz/dartz.dart';

abstract class AssetModelRepository {
  Future<Either<Failure, List<AssetModel>>> findAllAssetModel();
  Future<Either<Failure, AssetModel>> createAssetModel(AssetModel params);
  Future<Either<Failure, AssetModel>> updateAssetModel(AssetModel params);
  Future<Either<Failure, AssetModel>> findByIdAssetModel(int params);
  Future<Either<Failure, List<AssetModel>>> findAssetModelByQuery(
      String params);
}
