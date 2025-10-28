// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetsRequest extends Equatable {
  int? isMigration;
  String? assetIdOld;
  String? serialNumber;
  String? status;
  String? conditions;
  String? remarks;
  int? registredBy;
  int? assetModelId;
  int? colorId;
  String? purchaseOrder;
  int? quantity;
  int? locationId;
  int? uom;

  AssetsRequest({
    this.isMigration,
    this.assetIdOld,
    this.serialNumber,
    this.status,
    this.conditions,
    this.remarks,
    this.registredBy,
    this.assetModelId,
    this.colorId,
    this.purchaseOrder,
    this.quantity,
    this.locationId,
    this.uom,
  });

  factory AssetsRequest.fromJson(Map<String, dynamic> params) {
    return AssetsRequest(
      isMigration:
          params['is_migration'] != null ? params['is_migration'] as int : null,
      assetIdOld: params['asset_id_old'] != null
          ? params['asset_id_old'] as String
          : null,
      serialNumber: params['serial_number'] != null
          ? params['serial_number'] as String
          : null,
      status: params['status'] != null ? params['status'] as String : null,
      conditions:
          params['conditions'] != null ? params['conditions'] as String : null,
      remarks: params['remarks'] != null ? params['remarks'] as String : null,
      registredBy:
          params['registred_by'] != null ? params['registred_by'] as int : null,
      assetModelId: params['asset_model_id'] != null
          ? params['asset_model_id'] as int
          : null,
      colorId: params['color_id'] != null ? params['color_id'] as int : null,
      purchaseOrder: params['purchase_order'] != null
          ? params['purchase_order'] as String
          : null,
      quantity: params['quantity'] != null ? params['quantity'] as int : null,
      locationId:
          params['location_id'] != null ? params['location_id'] as int : null,
      uom: params['uom'] != null ? params['uom'] as int : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      serialNumber,
      status,
      conditions,
      remarks,
      registredBy,
      assetModelId,
      colorId,
      purchaseOrder,
      quantity,
      locationId,
      uom,
    ];
  }
}
