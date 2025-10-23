// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order.dart';
import 'package:asset_management_api/features/purchase_order/domain/repositories/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPurchaseOrderUseCase {
  FindAllPurchaseOrderUseCase(this._repository);

  final PurchaseOrderRepository _repository;

  Future<Either<Failure, List<PurchaseOrder>>> call() async {
    return _repository.findAllPurchaseOrder();
  }
}
