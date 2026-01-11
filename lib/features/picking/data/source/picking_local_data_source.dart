// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/picking/data/model/picking_detail_item_model.dart';
import 'package:asset_management_api/features/picking/data/model/picking_detail_response_model.dart';
import 'package:asset_management_api/features/picking/data/model/picking_header_model.dart';

abstract class PickingLocalDataSource {
  Future<List<PickingHeaderModel>> findAllPickingTask({
    required int userId,
  });
  Future<PickingDetailResponseModel> findPickingDetail({
    required int id,
    required int userId,
  });
  Future<String> pickedAsset({
    required int userId,
    required PickingDetailItemModel params,
  });
}
