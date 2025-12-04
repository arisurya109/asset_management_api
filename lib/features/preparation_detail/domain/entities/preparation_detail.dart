// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetail extends Equatable {
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

  PreparationDetail({
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'preparation_id': preparationId,
      'status': status,
      'notes': notes,
      'asset_model': {
        'id': assetModelId,
        'name': assetModel,
        'type': assetType,
        'brand': assetBrand,
        'category': assetCategory,
      },
      'quantity': {
        'target': quantityTarget,
        'picked': quantityPicked,
        'missing': quantityMissing,
      },
      'exception': {
        'status': exceptionStatus,
        'reason': exceptionReason,
      },
    };
  }

  factory PreparationDetail.fromJson(Map<String, dynamic> map) {
    return PreparationDetail(
      id: map['id'] != null ? map['id'] as int : null,
      preparationId:
          map['preparation_id'] != null ? map['preparation_id'] as int : null,
      assetModelId:
          map['asset_model_id'] != null ? map['asset_model_id'] as int : null,
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
