// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/asset_migration/domain/entities/asset_migration.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetMigrationModel extends Equatable {
  int? id;
  String? assetCode;
  String? assetIdOld;
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
  int? isConsumable;

  AssetMigrationModel({
    this.id,
    this.uom,
    this.assetCode,
    this.assetIdOld,
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
    this.isConsumable,
  });

  factory AssetMigrationModel.fromMap(Map<String, dynamic> map) {
    return AssetMigrationModel(
      id: map['id'] != null ? map['id'] as int : null,
      uom: map['uom'] != null ? map['uom'] as int : null,
      assetIdOld:
          map['asset_id_old'] != null ? map['asset_id_old'] as String : null,
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
      isConsumable:
          map['is_consumable'] != null ? map['is_consumable'] as int : null,
    );
  }

  factory AssetMigrationModel.fromEntity(AssetMigration params) {
    return AssetMigrationModel(
      id: params.id,
      uom: params.uom,
      assetIdOld: params.assetIdOld,
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
      isConsumable: params.isConsumable,
    );
  }

  AssetMigration toEntity() {
    return AssetMigration(
      id: id,
      uom: uom,
      assetIdOld: assetIdOld,
      serialNumber: serialNumber,
      assetCode: assetCode,
      assetModelId: assetModelId,
      brand: brand,
      color: color,
      colorId: colorId,
      conditions: conditions,
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
      isConsumable: isConsumable,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      uom,
      assetIdOld,
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
