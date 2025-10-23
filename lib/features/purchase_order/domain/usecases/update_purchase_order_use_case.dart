// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order.dart';
import 'package:asset_management_api/features/purchase_order/domain/repositories/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePurchaseOrderUseCase {
  UpdatePurchaseOrderUseCase(this._repository);

  final PurchaseOrderRepository _repository;

  Future<Either<Failure, PurchaseOrder>> call(PurchaseOrder params) async {
    return _repository.updatePurchaseOrder(params);
  }
}
