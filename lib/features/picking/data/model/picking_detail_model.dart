// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/picking/data/model/picking_detail_item_model.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingDetailModel extends Equatable {
  int? id;
  int? modelId;
  int? quantity;
  int? isConsumable;
  String? model;
  String? types;
  String? category;
  List<PickingDetailItemModel>? allocatedItems;

  PickingDetailModel({
    this.id,
    this.modelId,
    this.quantity,
    this.isConsumable,
    this.model,
    this.types,
    this.category,
    this.allocatedItems,
  });

  factory PickingDetailModel.fromDatabase(Map<String, dynamic> map) {
    return PickingDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      modelId: map['model_id'] != null ? map['model_id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      isConsumable:
          map['is_consumable'] != null ? map['is_consumable'] as int : null,
      model: map['model'] != null ? map['model'] as String : null,
      types: map['types'] != null ? map['types'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      allocatedItems: map['allocated_items'] != null
          ? (map['allocated_items'] as List)
              .map(
                (e) => PickingDetailItemModel.fromDatabase(
                  e as Map<String, dynamic>,
                ),
              )
              .toList()
          : null,
    );
  }

  PickingDetail toEntity() {
    return PickingDetail(
      id: id,
      category: category,
      isConsumable: isConsumable,
      model: model,
      modelId: modelId,
      quantity: quantity,
      types: types,
      allocatedItems: allocatedItems?.map((e) => e.toEntity()).toList(),
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
