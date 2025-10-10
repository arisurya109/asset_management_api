// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_models/data/model/asset_model_models.dart';

abstract class AssetModelLocalDataSource {
  Future<List<AssetModelModels>> findAllAssetModel();
  Future<AssetModelModels> createAssetModel(AssetModelModels params);
  Future<AssetModelModels> updateAssetModel(AssetModelModels params);
  Future<AssetModelModels> findByIdAssetModel(int params);
}
