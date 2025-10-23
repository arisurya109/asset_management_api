// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order.dart';
import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order_detail.dart';
import 'package:dartz/dartz.dart';

abstract class PurchaseOrderRepository {
  Future<Either<Failure, PurchaseOrder>> createPurchaseOrder(
    PurchaseOrder params,
  );
  Future<Either<Failure, List<PurchaseOrder>>> findAllPurchaseOrder();
  Future<Either<Failure, PurchaseOrder>> updatePurchaseOrder(
    PurchaseOrder params,
  );
  Future<Either<Failure, List<PurchaseOrderDetail>>>
      findPurchaseOrderDetailItem(
    int purchaseOrderId,
  );
}
