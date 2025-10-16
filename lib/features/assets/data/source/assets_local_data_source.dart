// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/features/assets/data/model/assets_response_model.dart';

abstract class AssetsLocalDataSource {
  Future<List<AssetsResponseModel>> findAllAssets();
}
