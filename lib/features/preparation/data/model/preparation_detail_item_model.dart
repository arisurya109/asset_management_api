// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail_item.dart';
import 'package:equatable/equatable.dart';

class PreparationDetailItemModel extends Equatable {
  int? id;
  int? preparationDetailId;
  int? assetId;
  int? quantity;
  String? status;
  String? assetCode;
  String? serialNumber;
  String? conditions;
  String? location;

  PreparationDetailItemModel({
    this.id,
    this.preparationDetailId,
    this.assetId,
    this.quantity,
    this.status,
    this.assetCode,
    this.serialNumber,
    this.conditions,
    this.location,
  });

  factory PreparationDetailItemModel.fromDatabase(Map<String, dynamic> params) {
    return PreparationDetailItemModel(
      id: params['id'] != null ? params['id'] as int : null,
      preparationDetailId: params['preparation_detail_id'] != null
          ? params['preparation_detail_id'] as int
          : null,
      assetId: params['asset_id'] != null ? params['asset_id'] as int : null,
      assetCode:
          params['asset_code'] != null ? params['asset_code'] as String : null,
      quantity: params['quantity'] != null ? params['quantity'] as int : null,
      status: params['status'] != null ? params['status'] as String : null,
      serialNumber: params['serial_number'] != null
          ? params['serial_number'] as String
          : null,
      conditions:
          params['conditions'] != null ? params['conditions'] as String : null,
      location:
          params['location'] != null ? params['location'] as String : null,
    );
  }

  PreparationDetailItem toEntity() {
    return PreparationDetailItem(
      id: id,
      preparationDetailId: preparationDetailId,
      assetId: assetId,
      assetCode: assetCode,
      conditions: conditions,
      location: location,
      quantity: quantity,
      serialNumber: serialNumber,
      status: status,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      preparationDetailId,
      assetId,
      quantity,
      status,
      assetCode,
      serialNumber,
      conditions,
      location,
    ];
  }
}
