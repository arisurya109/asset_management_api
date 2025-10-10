// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_type/data/model/type_model.dart';

abstract class AssetTypeLocalDataSource {
  Future<AssetTypeModel> createType(AssetTypeModel params);
  Future<AssetTypeModel> updateType(AssetTypeModel params);
  Future<AssetTypeModel> findByIdType(int params);
  Future<List<AssetTypeModel>> findAllType();
}
