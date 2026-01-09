// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail_item.dart';
import 'package:equatable/equatable.dart';

class PreparationDetail extends Equatable {
  int? id;
  int? preparationId;
  int? modelId;
  int? isConsumable;
  String? purchaseOrder;
  int? quantity;
  String? model;
  String? type;
  String? category;
  String? brand;
  List<PreparationDetailItem>? items;

  PreparationDetail({
    this.id,
    this.preparationId,
    this.modelId,
    this.isConsumable,
    this.purchaseOrder,
    this.quantity,
    this.model,
    this.type,
    this.category,
    this.brand,
    this.items,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'model_id': modelId,
      'is_consumable': isConsumable,
      'purchase_order': purchaseOrder,
      'quantity': quantity,
      'model': model,
      'type': type,
      'category': category,
      'brand': brand,
      'allocated_items': items?.map((e) => e.toJson()).toList() ?? [],
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
      modelId,
      purchaseOrder,
      quantity,
      model,
      type,
      category,
      brand,
      items,
    ];
  }
}
