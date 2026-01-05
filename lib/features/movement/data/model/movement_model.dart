// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management_api/features/movement/domain/entities/movement.dart';
import 'package:equatable/equatable.dart';

class MovementModel extends Equatable {
  MovementModel({
    this.type,
    this.assetId,
    this.fromLocation,
    this.destination,
    this.status,
    this.conditions,
    this.remarks,
  });

  factory MovementModel.fromEntity(Movement params) {
    return MovementModel(
      type: params.type,
      assetId: params.assetId,
      fromLocation: params.fromLocation,
      destination: params.destination,
      status: params.status,
      conditions: params.conditions,
      remarks: params.remarks,
    );
  }

  int? assetId;
  String? type;
  String? fromLocation;
  String? destination;
  String? status;
  String? conditions;
  String? remarks;

  @override
  List<Object?> get props =>
      [type, assetId, fromLocation, destination, status, conditions, remarks];
}
