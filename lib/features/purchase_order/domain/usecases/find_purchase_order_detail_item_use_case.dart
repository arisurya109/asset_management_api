// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order_detail.dart';
import 'package:asset_management_api/features/purchase_order/domain/repositories/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class FindPurchaseOrderDetailItemUseCase {
  FindPurchaseOrderDetailItemUseCase(this._repository);

  final PurchaseOrderRepository _repository;

  Future<Either<Failure, List<PurchaseOrderDetail>>> call(
    int purchaseOrderId,
  ) async {
    return _repository.findPurchaseOrderDetailItem(purchaseOrderId);
  }
}
