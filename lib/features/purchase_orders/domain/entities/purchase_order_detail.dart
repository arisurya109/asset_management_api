// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PurchaseOrderDetail extends Equatable {
  int? id;
  int? purchaseOrderId;
  int? assetModelId;
  String? assetName;
  String? assetType;
  String? assetCategory;
  String? assetBrand;
  int? quantity;

  PurchaseOrderDetail({
    this.id,
    this.purchaseOrderId,
    this.assetModelId,
    this.assetName,
    this.assetType,
    this.assetCategory,
    this.assetBrand,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'purchase_order_id': purchaseOrderId,
      'asset_model': {
        'id': assetModelId,
        'name': assetName,
        'type': assetType,
        'category': assetCategory,
        'brand': assetBrand,
      },
      'quantity': quantity,
    };
  }

  factory PurchaseOrderDetail.fromMap(Map<String, dynamic> map) {
    return PurchaseOrderDetail(
      id: map['id'] != null ? map['id'] as int : null,
      purchaseOrderId: map['purchase_order_id'] != null
          ? map['purchase_order_id'] as int
          : null,
      assetModelId:
          map['asset_model_id'] != null ? map['asset_model_id'] as int : null,
      assetName: map['asset_name'] != null ? map['asset_name'] as String : null,
      assetType: map['asset_type'] != null ? map['asset_type'] as String : null,
      assetCategory: map['asset_category'] != null
          ? map['asset_category'] as String
          : null,
      assetBrand:
          map['asset_brand'] != null ? map['asset_brand'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      purchaseOrderId,
      assetModelId,
      assetName,
      assetType,
      assetCategory,
      assetBrand,
      quantity,
    ];
  }
}
