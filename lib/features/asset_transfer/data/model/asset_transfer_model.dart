// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetTransferModel extends Equatable {
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

  AssetTransferModel({
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

  factory AssetTransferModel.fromDatabase(Map<String, dynamic> map) {
    return AssetTransferModel(
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

  factory AssetTransferModel.fromEntity(AssetTransfer params) {
    return AssetTransferModel(
      id: params.id,
      assetId: params.assetId,
      assetCode: params.assetCode,
      movementType: params.movementType,
      fromLocationId: params.fromLocationId,
      fromLocation: params.fromLocation,
      toLocationId: params.toLocationId,
      toLocation: params.toLocation,
      movementById: params.movementById,
      movementBy: params.movementBy,
      quantity: params.quantity,
      notes: params.notes,
    );
  }

  AssetTransfer toEntity() {
    return AssetTransfer(
      id: id,
      assetId: assetId,
      assetCode: assetCode,
      movementType: movementType,
      fromLocationId: fromLocationId,
      fromLocation: fromLocation,
      toLocationId: toLocationId,
      toLocation: toLocation,
      movementById: movementById,
      movementBy: movementBy,
      quantity: quantity,
      notes: notes,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      assetId,
      assetCode,
      movementType,
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
