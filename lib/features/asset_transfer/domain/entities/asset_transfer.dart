// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetTransfer extends Equatable {
  int? id;
  int? assetId;
  String? assetCode;
  String? movementType;
  int? fromLocationId;
  String? fromLocation;
  int? toLocationId;
  String? toLocation;
  int? movementById;
  String? movementBy;
  int? quantity;
  String? notes;

  AssetTransfer({
    this.id,
    this.assetId,
    this.assetCode,
    this.movementType,
    this.fromLocationId,
    this.fromLocation,
    this.toLocationId,
    this.toLocation,
    this.movementById,
    this.movementBy,
    this.quantity,
    this.notes,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'movement_type': movementType,
      'asset': {
        'id': assetId,
        'code': assetCode,
      },
      'from_location': {
        'id': fromLocationId,
        'name': fromLocation,
      },
      'to_location': {
        'id': id,
        'name': toLocation,
      },
      'movement_by': {
        'id': movementById,
        'name': movementBy,
      },
      'quantity': quantity,
      'notes': notes,
    };
  }

  factory AssetTransfer.fromRequest(Map<String, dynamic> map) {
    return AssetTransfer(
      id: map['id'] != null ? map['id'] as int : null,
      assetId: map['asset_id'] != null ? map['asset_id'] as int : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      movementType:
          map['movement_type'] != null ? map['movement_type'] as String : null,
      fromLocationId: map['from_location_id'] != null
          ? map['from_location_id'] as int
          : null,
      fromLocation:
          map['from_location'] != null ? map['from_location'] as String : null,
      toLocationId:
          map['to_location_id'] != null ? map['to_location_id'] as int : null,
      toLocation:
          map['to_location'] != null ? map['to_location'] as String : null,
      movementById:
          map['movement_by_id'] != null ? map['movement_by_id'] as int : null,
      movementBy:
          map['movement_by'] != null ? map['movement_by'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      assetId,
      assetCode,
      fromLocationId,
      fromLocation,
      toLocationId,
      toLocation,
      movementById,
      movementBy,
      quantity,
      notes,
    ];
  }
}
