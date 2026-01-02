// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:equatable/equatable.dart';

class Movement extends Equatable {
  Movement({
    this.type,
    this.assetCode,
    this.destination,
    this.status,
    this.conditions,
  });

  factory Movement.fromJson(Map<String, dynamic> params) {
    return Movement(
      type: params['type'] != null ? params['type'] as String : null,
      assetCode:
          params['asset_code'] != null ? params['asset_code'] as String : null,
      destination: params['destination'] != null
          ? params['destination'] as String
          : null,
      status: params['status'] != null ? params['status'] as String : null,
      conditions:
          params['conditions'] != null ? params['conditions'] as String : null,
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

    if (!type.isFilled()) return 'Type is required';
    if (!allowedTypes.contains(type)) return 'Invalid type';
    if (!assetCode.isFilled()) return 'Asset code cannot be empty';

    if (!destination.isFilled()) return 'Destination cannot be empty';

    if (type == 'RETURN') {
      if (!status.isFilled()) {
        return 'Status cannot be empty';
      }
      if (!conditions.isFilled()) {
        return 'Conditions cannot be empty';
      }
    }

    return null;
  }

  String? type;
  String? assetCode;
  String? destination;
  String? status;
  String? conditions;

  @override
  List<Object?> get props => [type, assetCode, destination, status, conditions];
}
