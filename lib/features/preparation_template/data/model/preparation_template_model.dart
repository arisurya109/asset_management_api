// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/preparation_template/data/model/preparation_template_item_model.dart';
import 'package:asset_management_api/features/preparation_template/domain/entities/preparation_template.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationTemplateModel extends Equatable {
  int? id;
  String? templateCode;
  String? name;
  String? description;
  int? isActive;
  int? createdById;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  List<PreparationTemplateItemModel>? items;

  PreparationTemplateModel({
    this.id,
    this.templateCode,
    this.name,
    this.description,
    this.isActive,
    this.createdById,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.items,
  });

  PreparationTemplate toEntity() {
    return PreparationTemplate(
      id: id,
      name: name,
      createdAt: createdAt,
      createdBy: createdBy,
      createdById: createdById,
      description: description,
      isActive: isActive,
      items: items?.map((e) => e.toEntity()).toList(),
      templateCode: templateCode,
      updatedAt: updatedAt,
    );
  }

  factory PreparationTemplateModel.fromDatabase(Map<String, dynamic> map) {
    return PreparationTemplateModel(
      id: map['id'] != null ? map['id'] as int : null,
      templateCode:
          map['template_code'] != null ? map['template_code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      isActive: map['is_active'] != null ? map['is_active'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdById:
          map['created_by_id'] != null ? map['created_by_id'] as int : null,
      createdBy: map['created_by'] != null ? map['created_by'] as String : null,
      createdAt:
          map['created_at'] != null ? map['created_at'] as DateTime : null,
      updatedAt:
          map['updated_at'] != null ? map['updated_at'] as DateTime : null,
      items: map['items'] != null
          ? List<PreparationTemplateItemModel>.from(
              (map['items'] as List).map<PreparationTemplateItemModel?>(
                (x) => PreparationTemplateItemModel.fromDatabase(
                  x as Map<String, dynamic>,
                ),
              ),
            )
          : null,
    );
  }

  factory PreparationTemplateModel.fromEntity(PreparationTemplate params) {
    return PreparationTemplateModel(
      id: params.id,
      createdAt: params.createdAt,
      createdBy: params.createdBy,
      createdById: params.createdById,
      description: params.description,
      isActive: params.isActive,
      items:
          params.items?.map(PreparationTemplateItemModel.fromEntity).toList(),
      name: params.name,
      templateCode: params.templateCode,
      updatedAt: params.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      templateCode,
      name,
      isActive,
      description,
      createdById,
      createdAt,
      updatedAt,
      createdBy,
      items,
    ];
  }
}
