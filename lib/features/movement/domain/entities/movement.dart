// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:equatable/equatable.dart';

class Movement extends Equatable {
  Movement({
    this.assetId,
    this.type,
    this.destination,
    this.fromLocation,
    this.status,
    this.conditions,
    this.remarks,
  });

  factory Movement.fromJson(Map<String, dynamic> params) {
    return Movement(
      assetId: params['asset_id'] != null ? params['asset_id'] as int : null,
      type: params['type'] != null ? params['type'] as String : null,
      fromLocation: params['from_location'] != null
          ? params['from_location'] as String
          : null,
      destination: params['destination'] != null
          ? params['destination'] as String
          : null,
      status: params['status'] != null ? params['status'] as String : null,
      conditions:
          params['conditions'] != null ? params['conditions'] as String : null,
      remarks: params['remarks'] != null ? params['remarks'] as String : null,
    );
  }

  String? validateRequest() {
    const allowedTypes = [
      'RECEIVE',
      'TRANSFER',
      'PREPARATION',
      'RETURN',
      'DISPOSAL',
    ];

    if (!assetId.toString().isFilled()) return 'Asset Id is required';
    if (!type.isFilled()) return 'Type is required';
    if (!allowedTypes.contains(type)) return 'Invalid type';

    if (!destination.isFilled()) return 'Destination cannot be empty';
    if (!fromLocation.isFilled()) return 'From Location cannot be empty';
    if (destination == fromLocation) {
      return 'The destination is the same as the current location';
    }

    if (type == 'RETURN') {
      if (!status.isFilled()) {
        return 'Status cannot be empty';
      }
      if (!conditions.isFilled()) {
        return 'Conditions cannot be empty';
      }
    }

    if (type == 'PREPARATION') {
      if (!status.isFilled()) {
        return 'Status cannot be empty';
      }
      if (status != 'USE' && status != 'REPAIR') {
        return 'Status not valid';
      }
    }

    return null;
  }

  int? assetId;
  String? type;
  String? destination;
  String? fromLocation;
  String? status;
  String? conditions;
  String? remarks;

  @override
  List<Object?> get props =>
      [assetId, type, fromLocation, destination, status, conditions, remarks];
}
