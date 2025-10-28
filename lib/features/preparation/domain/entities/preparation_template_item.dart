import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: must_be_immutable
class PreparationTemplateItem extends Equatable {
  int? id;
  int? templateId;
  int? modelId;
  int? quantity;
  String? notes;
  String? assetType;
  String? assetBrand;
  String? assetCategory;
  String? assetModel;

  PreparationTemplateItem({
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'template_id': templateId,
      'asset': {
        'type': assetType,
        'brand': assetBrand,
        'category': assetCategory,
        'model': assetModel,
      },
      'quantity': quantity,
      'notes': notes,
    };
  }

  factory PreparationTemplateItem.fromJson(Map<String, dynamic> map) {
    return PreparationTemplateItem(
      id: map['id'] != null ? map['id'] as int : null,
      templateId: map['template_id'] != null ? map['template_id'] as int : null,
      modelId: map['model_id'] != null ? map['model_id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
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
