// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingDetailItem extends Equatable {
  int? id;
  int? assetId;
  int? quantity;
  String? status;
  String? assetCode;
  String? serialNumber;
  int? locationId;
  String? location;

  PickingDetailItem({
    this.id,
    this.assetId,
    this.quantity,
    this.status,
    this.assetCode,
    this.serialNumber,
    this.locationId,
    this.location,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'asset_id': assetId,
      'quantity': quantity,
      'status': status,
      'asset_code': assetCode,
      'serial_number': serialNumber,
      'location_id': locationId,
      'location': location,
    };
  }

  factory PickingDetailItem.fromJson(Map<String, dynamic> map) {
    return PickingDetailItem(
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
