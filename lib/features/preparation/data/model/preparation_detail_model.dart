// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/features/preparation/data/model/preparation_detail_item_model.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail.dart';
import 'package:equatable/equatable.dart';

class PreparationDetailModel extends Equatable {
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
  List<PreparationDetailItemModel>? items;

  PreparationDetailModel({
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

  factory PreparationDetailModel.fromDatabase(Map<String, dynamic> map) {
    return PreparationDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      preparationId:
          map['preparation_id'] != null ? map['preparation_id'] as int : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      modelId: map['model_id'] != null ? map['model_id'] as int : null,
      isConsumable:
          map['is_consumable'] != null ? map['is_consumable'] as int : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      items: map['allocated_items'] != null
          ? (map['allocated_items'] as List)
              .map(
                (e) => PreparationDetailItemModel.fromDatabase(
                  e as Map<String, dynamic>,
                ),
              )
              .toList()
          : null,
    );
  }

  factory PreparationDetailModel.fromEntity(PreparationDetail params) {
    return PreparationDetailModel(
      id: params.id,
      brand: params.brand,
      category: params.category,
      isConsumable: params.isConsumable,
      model: params.model,
      modelId: params.modelId,
      preparationId: params.preparationId,
      purchaseOrder: params.purchaseOrder,
      quantity: params.quantity,
      type: params.type,
    );
  }

  PreparationDetail toEntity() {
    return PreparationDetail(
      id: id,
      preparationId: preparationId,
      brand: brand,
      category: category,
      isConsumable: isConsumable,
      model: model,
      modelId: modelId,
      purchaseOrder: purchaseOrder,
      quantity: quantity,
      type: type,
      items: items?.map((e) => e.toEntity()).toList() ?? [],
    );
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
