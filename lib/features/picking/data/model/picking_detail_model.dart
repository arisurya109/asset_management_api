// ignore_for_file: public_member_api_docs, sort_constructors_first

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
  int? assetId;
  String? status;
  String? assetCode;
  String? serialNumber;
  int? locationId;
  String? purchaseOrder;
  String? location;

  PickingDetailModel({
    this.id,
    this.modelId,
    this.quantity,
    this.isConsumable,
    this.model,
    this.types,
    this.category,
    this.assetId,
    this.status,
    this.assetCode,
    this.serialNumber,
    this.locationId,
    this.purchaseOrder,
    this.location,
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
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      assetId: map['asset_id'] != null ? map['asset_id'] as int : null,
      location: map['location'] != null ? map['location'] as String : null,
      locationId: map['location_id'] != null ? map['location_id'] as int : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      serialNumber:
          map['serial_number'] != null ? map['serial_number'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  factory PickingDetailModel.fromEntity(PickingDetail params) {
    return PickingDetailModel(
      id: params.id,
      assetCode: params.assetCode,
      assetId: params.assetId,
      category: params.category,
      isConsumable: params.isConsumable,
      location: params.location,
      locationId: params.locationId,
      model: params.model,
      modelId: params.modelId,
      purchaseOrder: params.purchaseOrder,
      quantity: params.quantity,
      serialNumber: params.serialNumber,
      status: params.status,
      types: params.types,
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
      assetCode: assetCode,
      assetId: assetId,
      location: location,
      locationId: locationId,
      purchaseOrder: purchaseOrder,
      serialNumber: serialNumber,
      status: status,
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
      assetId,
      status,
      assetCode,
      serialNumber,
      locationId,
      location,
      purchaseOrder
    ];
  }
}
