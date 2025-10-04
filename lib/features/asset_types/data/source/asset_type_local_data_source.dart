// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_types/asset_type_export.dart';

abstract class AssetTypeLocalDataSource {
  Future<AssetTypeModel> createAssetType(AssetTypeModel params);
  Future<AssetTypeModel> updateAssetType(AssetTypeModel params);
  Future<AssetTypeModel> findAssetTypeById(int params);
  Future<List<AssetTypeModel>> findAllAssetType();
  Future<List<AssetTypeModel>> findAssetTypeByIdBrand(int params);
}
