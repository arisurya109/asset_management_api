// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/features/assets/data/model/assets_detail_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_request_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_response_model.dart';

abstract class AssetsLocalDataSource {
  Future<List<AssetsResponseModel>> findAllAssets();
  Future<AssetsResponseModel> createAssets(AssetsRequestModel params);
  Future<List<AssetsDetailModel>> findAssetDetailById(int params);
  Future<AssetsResponseModel> createAssetTransfer({
    required int movementById,
    required int assetId,
    required String movementType,
    required int fromLocationId,
    required int toLocationId,
    int quantity = 1,
    String? notes,
  });
  Future<AssetsResponseModel> findAssetByAssetCodeAndLocation({
    required String assetCode,
    required String location,
  });
}
