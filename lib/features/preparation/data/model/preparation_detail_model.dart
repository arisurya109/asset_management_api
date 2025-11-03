// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetailModel extends Equatable {
  int? id;
  int? preparationId;
  int? assetModelId;
  int? quantityTarget;
  int? quantityPicked;
  int? quantityMissing;
  String? exceptionStatus;
  String? exceptionReason;
  String? status;
  String? notes;
  String? assetModel;
  String? assetType;
  String? assetCategory;
  String? assetBrand;

  PreparationDetailModel({
    this.id,
    this.preparationId,
    this.assetModelId,
    this.quantityTarget,
    this.quantityPicked,
    this.quantityMissing,
    this.exceptionStatus,
    this.exceptionReason,
    this.status,
    this.notes,
    this.assetModel,
    this.assetType,
    this.assetCategory,
    this.assetBrand,
  });

  Map<String, dynamic> toDatabasePartial() {
    final data = <String, dynamic>{};

    if (status != null) data['status'] = status;
    if (notes != null) data['notes'] = notes;
    if (assetModelId != null) data['asset_model_id'] = assetModelId;
    if (quantityTarget != null) data['quantity_target'] = quantityTarget;
    if (quantityPicked != null) data['quantity_picked'] = quantityPicked;
    if (quantityMissing != null) data['quantity_missing'] = quantityMissing;
    if (exceptionStatus != null) data['exception_status'] = exceptionStatus;
    if (exceptionReason != null) data['exception_reason'] = exceptionReason;

    return data;
  }

  factory PreparationDetailModel.fromDatabase(Map<String, dynamic> map) {
    return PreparationDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      preparationId:
          map['preparation_id'] != null ? map['preparation_id'] as int : null,
      assetModelId:
          map['asset_model_id'] != null ? map['asset_model_id'] as int : null,
      assetModel:
          map['asset_model'] != null ? map['asset_model'] as String : null,
      assetBrand:
          map['asset_brand'] != null ? map['asset_brand'] as String : null,
      assetCategory: map['asset_category'] != null
          ? map['asset_category'] as String
          : null,
      assetType: map['asset_type'] != null ? map['asset_type'] as String : null,
      quantityTarget:
          map['quantity_target'] != null ? map['quantity_target'] as int : null,
      quantityPicked:
          map['quantity_picked'] != null ? map['quantity_picked'] as int : null,
      quantityMissing: map['quantity_missing'] != null
          ? map['quantity_missing'] as int
          : null,
      exceptionStatus: map['exception_status'] != null
          ? map['exception_status'] as String
          : null,
      exceptionReason: map['exception_reason'] != null
          ? map['exception_reason'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  factory PreparationDetailModel.fromEntity(PreparationDetail params) {
    return PreparationDetailModel(
      id: params.id,
      assetBrand: params.assetBrand,
      assetCategory: params.assetCategory,
      assetModel: params.assetModel,
      assetModelId: params.assetModelId,
      assetType: params.assetType,
      exceptionReason: params.exceptionReason,
      exceptionStatus: params.exceptionStatus,
      notes: params.notes,
      preparationId: params.preparationId,
      quantityMissing: params.quantityMissing,
      quantityPicked: params.quantityPicked,
      quantityTarget: params.quantityTarget,
      status: params.status,
    );
  }

  PreparationDetail toEntity() {
    return PreparationDetail(
      id: id,
      preparationId: preparationId,
      assetBrand: assetBrand,
      assetCategory: assetCategory,
      assetModel: assetModel,
      assetModelId: assetModelId,
      assetType: assetType,
      exceptionReason: exceptionReason,
      exceptionStatus: exceptionStatus,
      notes: notes,
      quantityMissing: quantityMissing,
      quantityPicked: quantityPicked,
      quantityTarget: quantityTarget,
      status: status,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      preparationId,
      assetModelId,
      quantityTarget,
      quantityPicked,
      quantityMissing,
      exceptionStatus,
      exceptionReason,
      status,
      notes,
      assetModel,
      assetType,
      assetCategory,
      assetBrand,
    ];
  }
}
