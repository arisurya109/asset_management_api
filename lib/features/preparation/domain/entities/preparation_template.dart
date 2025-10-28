// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/preparation/domain/entities/preparation_template_item.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationTemplate extends Equatable {
  int? id;
  String? templateCode;
  String? name;
  String? description;
  int? isActive;
  int? createdById;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  List<PreparationTemplateItem>? items;

  PreparationTemplate({
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'template_code': templateCode,
      'name': name,
      'description': description,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'created_by': createdBy,
      'created_by_id': createdById,
      'items': items?.map((e) => e.toJson()).toList(),
    };
  }

  factory PreparationTemplate.fromJson(Map<String, dynamic> map) {
    return PreparationTemplate(
      id: map['id'] != null ? map['id'] as int : null,
      templateCode:
          map['template_code'] != null ? map['template_code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      isActive: map['is_active'] != null ? map['is_active'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdById:
          map['created_by_id'] != null ? map['created_by_id'] as int : null,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'] as String)
          : null,
      items: map['items'] != null
          ? List<PreparationTemplateItem>.from(
              (map['items'] as List).map<PreparationTemplateItem?>(
                (x) =>
                    PreparationTemplateItem.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
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
