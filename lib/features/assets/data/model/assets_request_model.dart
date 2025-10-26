// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management_api/features/assets/domain/entities/assets_request.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetsRequestModel extends Equatable {
  int? isMigration;
  String? assetIdOld;
  String? serialNumber;
  String? status;
  String? conditions;
  String? remarks;
  int? registredBy;
  int? assetModelId;
  int? colorId;
  String? purchaseOrderNumber;
  int? quantity;
  int? locationId;
  int? uom;

  AssetsRequestModel({
    this.isMigration,
    this.assetIdOld,
    this.serialNumber,
    this.status,
    this.conditions,
    this.remarks,
    this.registredBy,
    this.assetModelId,
    this.colorId,
    this.purchaseOrderNumber,
    this.quantity,
    this.locationId,
    this.uom,
  });

  factory AssetsRequestModel.fromEntity(AssetsRequest params) {
    return AssetsRequestModel(
      assetIdOld: params.assetIdOld,
      isMigration: params.isMigration,
      serialNumber: params.serialNumber,
      status: params.status,
      conditions: params.conditions,
      remarks: params.remarks,
      registredBy: params.registredBy,
      assetModelId: params.assetModelId,
      colorId: params.colorId,
      purchaseOrderNumber: params.purchaseOrderNumber,
      quantity: params.quantity,
      locationId: params.locationId,
      uom: params.uom,
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
      purchaseOrderNumber,
      quantity,
      locationId,
      uom,
    ];
  }
}
