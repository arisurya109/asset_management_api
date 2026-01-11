// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/picking/domain/entities/picking_detail_item.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingDetail extends Equatable {
  int? id;
  int? modelId;
  int? quantity;
  int? isConsumable;
  String? model;
  String? types;
  String? category;
  List<PickingDetailItem>? allocatedItems;

  PickingDetail({
    this.id,
    this.modelId,
    this.quantity,
    this.isConsumable,
    this.model,
    this.types,
    this.category,
    this.allocatedItems,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'model_id': modelId,
      'quantity': quantity,
      'is_consumable': isConsumable,
      'model': model,
      'types': types,
      'category': category,
      'allocated_items': allocatedItems?.map((e) => e.toJson()).toList(),
    };
  }

  factory PickingDetail.fromJson(Map<String, dynamic> map) {
    return PickingDetail(
      id: map['id'] != null ? map['id'] as int : null,
      modelId: map['modelId'] != null ? map['modelId'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      isConsumable:
          map['isConsumable'] != null ? map['isConsumable'] as int : null,
      model: map['model'] != null ? map['model'] as String : null,
      types: map['types'] != null ? map['types'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      modelId,
      quantity,
      isConsumable,
      model,
      types,
      category,
    ];
  }
}
