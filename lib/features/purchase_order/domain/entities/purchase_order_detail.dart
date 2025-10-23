import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: must_be_immutable
class PurchaseOrderDetail extends Equatable {
  int? id;
  int? purchaseOrderId;
  int? modelId;
  int? quantity;
  String? poNumber;
  String? types;
  String? brand;
  String? category;
  String? model;

  PurchaseOrderDetail({
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'po_number': poNumber,
      'types': types,
      'brand': brand,
      'category': category,
      'model': model,
      'quantity': quantity,
    };
  }

  factory PurchaseOrderDetail.fromJson(Map<String, dynamic> map) {
    return PurchaseOrderDetail(
      purchaseOrderId: map['purchase_order_id'] != null
          ? map['purchase_order_id'] as int
          : null,
      modelId: map['model_id'] != null ? map['model_id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
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
