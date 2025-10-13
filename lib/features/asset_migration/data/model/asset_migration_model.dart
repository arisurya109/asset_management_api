// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/features/asset_migration/domain/entities/asset_migration.dart';
import 'package:equatable/equatable.dart';

class AssetMigrationModel extends Equatable {
  int? id;
  int? isMigration;
  String? assetCode;
  String? serialNumber;
  String? status;
  int? uom;
  String? conditions;
  String? remarks;
  int? registredBy;
  int? assetModelId;
  String? model;
  String? brand;
  String? type;
  int? colorId;
  String? color;
  String? purchaseOrder;
  int? quantity;
  int? locationDetailId;
  String? locationDetail;
  String? location;

  AssetMigrationModel({
    this.id,
    this.isMigration,
    this.assetCode,
    this.serialNumber,
    this.status,
    this.conditions,
    this.remarks,
    this.registredBy,
    this.assetModelId,
    this.model,
    this.brand,
    this.type,
    this.colorId,
    this.color,
    this.purchaseOrder,
    this.quantity,
    this.locationDetailId,
    this.locationDetail,
    this.location,
  });

  factory AssetMigrationModel.fromMap(Map<String, dynamic> map) {
    return AssetMigrationModel(
      id: map['id'] != null ? map['id'] as int : null,
      isMigration:
          map['is_migration'] != null ? map['is_migration'] as int : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      serialNumber:
          map['serial_number'] != null ? map['serial_number'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      conditions:
          map['conditions'] != null ? map['conditions'] as String : null,
      remarks: map['remarks'] != null ? map['remarks'] as String : null,
      registredBy:
          map['registred_by'] != null ? map['registred_by'] as int : null,
      assetModelId:
          map['asset_model_id'] != null ? map['asset_model_id'] as int : null,
      model: map['model'] != null ? map['model'] as String : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      colorId: map['color_id'] != null ? map['color_id'] as int : null,
      color: map['color'] != null ? map['color'] as String : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      locationDetailId: map['location_detail_id'] != null
          ? map['location_detail_id'] as int
          : null,
      locationDetail: map['location_detail'] != null
          ? map['location_detail'] as String
          : null,
      location: map['location'] != null ? map['location'] as String : null,
    );
  }

  factory AssetMigrationModel.fromEntity(AssetMigration params) {
    return AssetMigrationModel(
      id: params.id,
      isMigration: params.isMigration,
      assetCode: params.assetCode,
      serialNumber: params.serialNumber,
      status: params.status,
      conditions: params.conditions,
      remarks: params.remarks,
      registredBy: params.registredBy,
      assetModelId: params.assetModelId,
      model: params.model,
      brand: params.brand,
      type: params.type,
      colorId: params.colorId,
      color: params.color,
      purchaseOrder: params.purchaseOrder,
      quantity: params.quantity,
      locationDetailId: params.locationDetailId,
      locationDetail: params.locationDetail,
      location: params.location,
    );
  }

  AssetMigration toEntity() {
    return AssetMigration(
      id: id,
      serialNumber: serialNumber,
      assetCode: assetCode,
      assetModelId: assetModelId,
      brand: brand,
      color: color,
      colorId: colorId,
      conditions: conditions,
      isMigration: isMigration,
      location: location,
      locationDetail: locationDetail,
      locationDetailId: locationDetailId,
      model: model,
      purchaseOrder: purchaseOrder,
      quantity: quantity,
      registredBy: registredBy,
      remarks: remarks,
      status: status,
      type: type,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      uom,
      isMigration,
      assetCode,
      serialNumber,
      status,
      conditions,
      remarks,
      registredBy,
      assetModelId,
      model,
      brand,
      type,
      colorId,
      color,
      purchaseOrder,
      quantity,
      locationDetailId,
      locationDetail,
      location,
    ];
  }
}
