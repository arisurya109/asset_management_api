// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/preparation/domain/entities/preparation_item.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationItemModel extends Equatable {
  int? id;
  int? preparationDetailId;
  int? preparationId;
  int? assetId;
  int? pickedById;
  int? quantity;
  int? locationId;
  String? assetCode;
  int? assetModelId;
  String? assetModel;
  String? assetCategory;
  String? assetBrand;
  String? assetType;
  String? pickedBy;
  String? location;
  String? purchaseOrder;

  PreparationItemModel({
    this.id,
    this.preparationDetailId,
    this.preparationId,
    this.assetId,
    this.pickedById,
    this.quantity,
    this.locationId,
    this.assetCode,
    this.assetModelId,
    this.assetModel,
    this.assetCategory,
    this.assetBrand,
    this.assetType,
    this.pickedBy,
    this.location,
    this.purchaseOrder,
  });

  factory PreparationItemModel.fromDatabase(Map<String, dynamic> map) {
    return PreparationItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      preparationDetailId: map['preparation_detail_id'] != null
          ? map['preparation_detail_id'] as int
          : null,
      preparationId:
          map['preparation_id'] != null ? map['preparation_id'] as int : null,
      assetId: map['asset_id'] != null ? map['asset_id'] as int : null,
      pickedById:
          map['picked_by_id'] != null ? map['picked_by_id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      locationId: map['location_id'] != null ? map['location_id'] as int : null,
      assetModelId:
          map['asset_model_id'] != null ? map['asset_model_id'] as int : null,
      assetBrand:
          map['asset_brand'] != null ? map['asset_brand'] as String : null,
      assetCategory: map['asset_category'] != null
          ? map['asset_category'] as String
          : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      assetModel:
          map['asset_model'] != null ? map['asset_model'] as String : null,
      assetType: map['asset_type'] != null ? map['asset_type'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      pickedBy: map['picked_by'] != null ? map['picked_by'] as String : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
    );
  }

  factory PreparationItemModel.fromEntity(PreparationItem params) {
    return PreparationItemModel(
      id: params.id,
      assetBrand: params.assetBrand,
      assetCategory: params.assetCategory,
      assetCode: params.assetCode,
      assetId: params.assetId,
      assetModel: params.assetModel,
      assetModelId: params.assetModelId,
      assetType: params.assetType,
      location: params.location,
      locationId: params.locationId,
      pickedBy: params.pickedBy,
      pickedById: params.pickedById,
      preparationDetailId: params.preparationDetailId,
      preparationId: params.preparationId,
      quantity: params.quantity,
      purchaseOrder: params.purchaseOrder,
    );
  }

  PreparationItem toEntity() {
    return PreparationItem(
      id: id,
      assetBrand: assetBrand,
      assetCategory: assetCategory,
      assetCode: assetCode,
      assetId: assetId,
      assetModel: assetModel,
      assetModelId: assetModelId,
      assetType: assetType,
      location: location,
      locationId: locationId,
      pickedBy: pickedBy,
      pickedById: pickedById,
      preparationDetailId: preparationDetailId,
      preparationId: preparationId,
      quantity: quantity,
      purchaseOrder: purchaseOrder,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      preparationDetailId,
      preparationId,
      assetId,
      pickedById,
      quantity,
      locationId,
      assetCode,
      assetModelId,
      assetModel,
      assetCategory,
      assetBrand,
      assetType,
      purchaseOrder,
    ];
  }
}
