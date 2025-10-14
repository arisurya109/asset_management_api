// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_migration/data/model/asset_migration_model.dart';

abstract class AssetMigrationLocalDataSource {
  Future<List<AssetMigrationModel>> findAllAsset();
  Future<AssetMigrationModel> createAssetConsumable(AssetMigrationModel params);
  Future<AssetMigrationModel> createNewAsset(AssetMigrationModel params);
  Future<AssetMigrationModel> migrationAsset(AssetMigrationModel params);
}
