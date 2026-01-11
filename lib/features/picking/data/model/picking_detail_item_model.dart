// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/picking/domain/entities/picking_detail_item.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingDetailItemModel extends Equatable {
  int? id;
  int? assetId;
  int? quantity;
  String? status;
  String? assetCode;
  String? serialNumber;
  int? locationId;
  String? location;

  PickingDetailItemModel({
    this.id,
    this.assetId,
    this.quantity,
    this.status,
    this.assetCode,
    this.serialNumber,
    this.locationId,
    this.location,
  });

  factory PickingDetailItemModel.fromDatabase(Map<String, dynamic> map) {
    return PickingDetailItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      assetId: map['asset_id'] != null ? map['asset_id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      serialNumber:
          map['serial_number'] != null ? map['serial_number'] as String : null,
      locationId: map['location_id'] != null ? map['location_id'] as int : null,
      location: map['location'] != null ? map['location'] as String : null,
    );
  }

  factory PickingDetailItemModel.fromEntity(PickingDetailItem params) {
    return PickingDetailItemModel(
      id: params.id,
      assetCode: params.assetCode,
      assetId: params.assetId,
      location: params.location,
      locationId: params.locationId,
      quantity: params.quantity,
      serialNumber: params.serialNumber,
      status: params.status,
    );
  }

  PickingDetailItem toEntity() {
    return PickingDetailItem(
      id: id,
      assetCode: assetCode,
      assetId: assetId,
      location: location,
      locationId: locationId,
      quantity: quantity,
      serialNumber: serialNumber,
      status: status,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      assetId,
      quantity,
      status,
      assetCode,
      serialNumber,
      locationId,
      location,
    ];
  }
}
