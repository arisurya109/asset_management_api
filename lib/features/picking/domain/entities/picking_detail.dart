// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/core/extensions/string_ext.dart';
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
  int? assetId;
  String? status;
  String? assetCode;
  String? serialNumber;
  int? locationId;
  String? purchaseOrder;
  String? location;

  PickingDetail({
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'model_id': modelId,
      'quantity': quantity,
      'is_consumable': isConsumable,
      'model': model,
      'types': types,
      'category': category,
      'asset_id': assetId,
      'status': status,
      'asset_code': assetCode,
      'serial_number': serialNumber,
      'location_id': locationId,
      'purchase_order': purchaseOrder,
      'location': location,
    };
  }

  factory PickingDetail.fromJsonPickAsset(Map<String, dynamic> map) {
    return PickingDetail(
      id: map['id'] != null ? map['id'] as int : null,
      assetId: map['asset_id'] != null ? map['asset_id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      locationId: map['location_id'] != null ? map['location_id'] as int : null,
    );
  }

  String? validatePickAsset() {
    if (id == null) {
      return 'Id cannot empty';
    } else if (assetId == null) {
      return 'Asset cannot empty';
    } else if (quantity == null) {
      return 'Quantity cannot empty';
    } else if (!status.isFilled()) {
      return 'Status cannot empty';
    } else if (locationId == null) {
      return 'Location cannot empty';
    } else {
      return null;
    }
  }
}
