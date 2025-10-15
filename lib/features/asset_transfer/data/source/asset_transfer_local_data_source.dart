// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/features/asset_transfer/data/model/asset_transfer_model.dart';

abstract class AssetTransferLocalDataSource {
  Future<AssetTransferModel> createAssetTransfer(AssetTransferModel params);
}
