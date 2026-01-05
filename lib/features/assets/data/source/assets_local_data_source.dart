// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/features/assets/data/model/assets_detail_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_request_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_response_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_response_pagination_model.dart';

abstract class AssetsLocalDataSource {
  Future<List<AssetsResponseModel>> findAllAssets();
  Future<AssetsResponseModel> registrationAsset(AssetsRequestModel params);
  Future<AssetsResponseModel> migrationAsset(AssetsRequestModel params);
  Future<List<AssetsDetailModel>> findAssetDetailById(int params);
  Future<List<AssetsResponseModel>> findAssetByQuery({
    required String params,
  });
  Future<AssetsResponsePaginationModel> findAssetByPagination({
    required int page,
    required int limit,
    String? query,
  });
}
