// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/purchase_order/data/model/purchase_order_detail_model.dart';
import 'package:asset_management_api/features/purchase_order/data/model/purchase_order_model.dart';

abstract class PurchaseOrderLocalDataSource {
  Future<PurchaseOrderModel> createPurchaseOrder(PurchaseOrderModel params);
  Future<List<PurchaseOrderModel>> findAllPurchaseOrder();
  Future<PurchaseOrderModel> updatePurchaseOrder(PurchaseOrderModel params);
  Future<List<PurchaseOrderDetailModel>> findPurchaserOrderDetailItem(
    int purchaseOrderId,
  );
}
