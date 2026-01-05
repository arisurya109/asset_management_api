// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_categories/data/model/asset_category_model.dart';

abstract class AssetCategoryLocalDataSource {
  Future<AssetCategoryModel> createAssetCategory(AssetCategoryModel params);
  Future<List<AssetCategoryModel>> findAllAssetCategory();
  Future<AssetCategoryModel> updateAssetCategory(AssetCategoryModel params);
  Future<AssetCategoryModel> findByIdAssetCategory(int params);
  Future<List<AssetCategoryModel>> findAssetCategoryByQuery(String params);
}
