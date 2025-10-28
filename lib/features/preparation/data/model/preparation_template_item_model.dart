import 'package:asset_management_api/features/preparation/domain/entities/preparation_template_item.dart';
import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: must_be_immutable
class PreparationTemplateItemModel extends Equatable {
  int? id;
  int? templateId;
  int? modelId;
  int? quantity;
  String? notes;
  String? assetType;
  String? assetBrand;
  String? assetCategory;
  String? assetModel;

  PreparationTemplateItemModel({
    this.id,
    this.templateId,
    this.modelId,
    this.quantity,
    this.notes,
    this.assetType,
    this.assetBrand,
    this.assetCategory,
    this.assetModel,
  });

  PreparationTemplateItem toEntity() {
    return PreparationTemplateItem(
      id: id,
      assetBrand: assetBrand,
      assetCategory: assetCategory,
      assetModel: assetModel,
      assetType: assetType,
      modelId: modelId,
      notes: notes,
      quantity: quantity,
      templateId: templateId,
    );
  }

  factory PreparationTemplateItemModel.fromDatabase(Map<String, dynamic> map) {
    return PreparationTemplateItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      templateId: map['template_id'] != null ? map['template_id'] as int : null,
      modelId: map['model_id'] != null ? map['model_id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      assetType: map['asset_type'] != null ? map['asset_type'] as String : null,
      assetBrand:
          map['asset_brand'] != null ? map['asset_brand'] as String : null,
      assetCategory: map['asset_category'] != null
          ? map['asset_category'] as String
          : null,
      assetModel:
          map['asset_model'] != null ? map['asset_model'] as String : null,
    );
  }

  factory PreparationTemplateItemModel.fromEntity(
    PreparationTemplateItem params,
  ) {
    return PreparationTemplateItemModel(
      id: params.id,
      assetBrand: params.assetBrand,
      assetCategory: params.assetCategory,
      assetModel: params.assetModel,
      assetType: params.assetType,
      modelId: params.modelId,
      notes: params.notes,
      quantity: params.quantity,
      templateId: params.templateId,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      templateId,
      modelId,
      quantity,
      notes,
      assetType,
      assetBrand,
      assetCategory,
      assetModel,
    ];
  }
}
