// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/purchase_order/data/model/purchase_order_model.dart';
import 'package:asset_management_api/features/purchase_order/data/source/purchase_order_local_data_source.dart';
import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order.dart';
import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order_detail.dart';
import 'package:asset_management_api/features/purchase_order/domain/repositories/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class PurchaseOrderRepositoryImpl implements PurchaseOrderRepository {
  PurchaseOrderRepositoryImpl(this._source);

  final PurchaseOrderLocalDataSource _source;

  @override
  Future<Either<Failure, PurchaseOrder>> createPurchaseOrder(
    PurchaseOrder params,
  ) async {
    try {
      final response = await _source.createPurchaseOrder(
        PurchaseOrderModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseOrder>>> findAllPurchaseOrder() async {
    try {
      final response = await _source.findAllPurchaseOrder();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseOrderDetail>>>
      findPurchaseOrderDetailItem(int purchaseOrderId) async {
    try {
      final response = await _source.findPurchaserOrderDetailItem(
        purchaseOrderId,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PurchaseOrder>> updatePurchaseOrder(
      PurchaseOrder params) {
    // TODO: implement updatePurchaseOrder
    throw UnimplementedError();
  }
}
