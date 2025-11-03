// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationItem extends Equatable {
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

  PreparationItem({
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
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'preparation_id': preparationId,
      'preparation_detail_id': preparationDetailId,
      'asset': {
        'id': assetId,
        'code': assetCode,
        'model': {
          'id': assetModelId,
          'name': assetModel,
        },
        'category': assetCategory,
        'brand': assetBrand,
        'type': assetType,
      },
      'picked': {
        'id': pickedById,
        'name': pickedBy,
      },
      'quantity': quantity,
      'location': {
        'id': locationId,
        'name': location,
      },
    };
  }

  factory PreparationItem.fromJson(Map<String, dynamic> map) {
    return PreparationItem(
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
    ];
  }
}
