// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/assets/data/model/asset_model.dart';

abstract class AssetLocalDataSource {
  Future<List<AssetModel>> findAllAsset();
  Future<AssetModel> createAsset(AssetModel params);
  Future<AssetModel> updateAsset(AssetModel params);
  Future<AssetModel> findAssetById(int id);
}
