// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management_api/features/movement/domain/entities/movement.dart';
import 'package:equatable/equatable.dart';

class MovementModel extends Equatable {
  MovementModel({
    this.type,
    this.assetCode,
    this.destination,
    this.status,
    this.conditions,
  });

  factory MovementModel.fromEntity(Movement params) {
    return MovementModel(
      type: params.type,
      assetCode: params.assetCode,
      destination: params.destination,
      status: params.status,
      conditions: params.conditions,
    );
  }

  String? type;
  String? assetCode;
  String? destination;
  String? status;
  String? conditions;

  @override
  List<Object?> get props => [type, assetCode, destination, status, conditions];
}
