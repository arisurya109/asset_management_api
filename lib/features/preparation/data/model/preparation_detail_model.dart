// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetailModel extends Equatable {
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

  PreparationDetailModel({
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

  factory PreparationDetailModel.fromDatabase(Map<String, dynamic> map) {
    return PreparationDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      preparationId:
          map['preparation_id'] != null ? map['preparation_id'] as int : null,
      assetId: map['asset_id'] != null ? map['asset_id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      locationId: map['location_id'] != null ? map['location_id'] as int : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      location: map['location'] != null ? map['location'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      isConsumable:
          map['is_consumable'] != null ? map['is_consumable'] as int : null,
    );
  }

  factory PreparationDetailModel.fromEntity(PreparationDetail params) {
    return PreparationDetailModel(
      id: params.id,
      assetCode: params.assetCode,
      assetId: params.assetId,
      category: params.category,
      isConsumable: params.isConsumable,
      location: params.location,
      locationId: params.locationId,
      model: params.model,
      modelId: params.modelId,
      preparationId: params.preparationId,
      purchaseOrder: params.purchaseOrder,
      quantity: params.quantity,
      status: params.status,
    );
  }

  PreparationDetail toEntity() {
    return PreparationDetail(
      id: id,
      assetCode: assetCode,
      assetId: assetId,
      category: category,
      isConsumable: isConsumable,
      location: location,
      locationId: locationId,
      model: model,
      modelId: modelId,
      preparationId: preparationId,
      purchaseOrder: purchaseOrder,
      quantity: quantity,
      status: status,
    );
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
