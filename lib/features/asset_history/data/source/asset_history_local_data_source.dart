// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_history/data/model/asset_history_model.dart';

// ignore: one_member_abstracts
abstract class AssetHistoryLocalDataSource {
  Future<List<AssetHistoryModel>> findAllAssetHistoryById(int params);
}
