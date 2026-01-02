// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/features/inventory/data/model/inventory_model.dart';

abstract class InventoryLocalDataSource {
  Future<InventoryModel> findInventory(String params);
}
