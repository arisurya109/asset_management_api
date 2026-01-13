// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetail extends Equatable {
  int? id;
  int? preparationId;
  int? assetId;
  int? quantity;
  String? status;
  String? assetCode;
  int? locationId;
  String? purchaseOrder;
  String? location;
  int? modelId;
  String? model;
  int? isConsumable;
  String? category;

  PreparationDetail({
    this.id,
    this.preparationId,
    this.assetId,
    this.quantity,
    this.status,
    this.assetCode,
    this.locationId,
    this.purchaseOrder,
    this.location,
    this.modelId,
    this.model,
    this.isConsumable,
    this.category,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'preparation_id': preparationId,
      'asset_id': assetId,
      'quantity': quantity,
      'status': status,
      'asset_code': assetCode,
      'location_id': locationId,
      'purchase_order': purchaseOrder,
      'location': location,
      'model': model,
      'is_consumable': isConsumable,
      'category': category,
    };
  }

  factory PreparationDetail.fromJsonAdd(Map<String, dynamic> map) {
    return PreparationDetail(
      preparationId:
          map['preparation_id'] != null ? map['preparation_id'] as int : null,
      modelId: map['model_id'] != null ? map['model_id'] as int : null,
      isConsumable:
          map['is_consumable'] != null ? map['is_consumable'] as int : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  String? validateAdd() {
    if (modelId == null) {
      return 'Asset Model cannot empty';
    } else if (isConsumable == null) {
      return 'Type asset cannot empty';
    } else if (quantity == null) {
      return 'Quantity cannot empty';
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props {
    return [
      id,
      preparationId,
      assetId,
      modelId,
      quantity,
      status,
      assetCode,
      locationId,
      purchaseOrder,
      location,
      model,
      isConsumable,
      category,
    ];
  }
}
