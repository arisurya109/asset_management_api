import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order_detail.dart';
import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: must_be_immutable
class PurchaseOrderDetailModel extends Equatable {
  int? id;
  int? purchaseOrderId;
  int? modelId;
  int? quantity;
  String? poNumber;
  String? types;
  String? brand;
  String? category;
  String? model;

  PurchaseOrderDetailModel({
    this.id,
    this.purchaseOrderId,
    this.modelId,
    this.quantity,
    this.poNumber,
    this.types,
    this.brand,
    this.category,
    this.model,
  });

  PurchaseOrderDetail toEntity() {
    return PurchaseOrderDetail(
      id: id,
      poNumber: poNumber,
      model: model,
      brand: brand,
      category: category,
      types: types,
      quantity: quantity,
    );
  }

  factory PurchaseOrderDetailModel.fromDatabase(Map<String, dynamic> map) {
    return PurchaseOrderDetailModel(
      purchaseOrderId: map['purchase_order_id'] != null
          ? map['purchase_order_id'] as int
          : null,
      modelId: map['model_id'] != null ? map['model_id'] as int : null,
      poNumber: map['po_number'] != null ? map['po_number'] as String : null,
      types: map['types'] != null ? map['types'] as String : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  factory PurchaseOrderDetailModel.fromEntity(PurchaseOrderDetail params) {
    return PurchaseOrderDetailModel(
      purchaseOrderId: params.purchaseOrderId,
      id: params.id,
      brand: params.brand,
      category: params.category,
      model: params.model,
      modelId: params.modelId,
      poNumber: params.poNumber,
      quantity: params.quantity,
      types: params.types,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      purchaseOrderId,
      modelId,
      quantity,
      poNumber,
      types,
      brand,
      category,
      model,
    ];
  }
}
