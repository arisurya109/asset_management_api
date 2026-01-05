// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_brand/data/model/asset_brand_model.dart';

abstract class AssetBrandLocalDataSource {
  Future<List<AssetBrandModel>> findAllAssetBrand();
  Future<AssetBrandModel> findByIdAssetBrand(int params);
  Future<AssetBrandModel> createAssetBrand(AssetBrandModel params);
  Future<AssetBrandModel> updateAssetBrand(AssetBrandModel params);
  Future<List<AssetBrandModel>> findAssetBrandByQuery(String params);
}
