// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors

import 'package:equatable/equatable.dart';

class AssetModel extends Equatable {
  AssetModel({
    this.id,
    this.name,
    this.hasSerial,
    this.isConsumable,
    this.unit,
    this.createdBy,
    this.lastUpdatedBy,
    this.typeId,
    this.categoryId,
    this.brandId,
    this.typeName,
    this.categoryName,
    this.brandName,
  });

  factory AssetModel.fromRequest(Map<String, dynamic> params) {
    return AssetModel(
      id: params['id'] != null ? params['id'] as int : null,
      name: params['name'] != null ? params['name'] as String : null,
      hasSerial:
          params['has_serial'] != null ? params['has_serial'] as int : null,
      isConsumable: params['is_consumable'] != null
          ? params['is_consumable'] as int
          : null,
      unit: params['unit'] != null ? params['unit'] as int : null,
      createdBy:
          params['created_by'] != null ? params['created_by'] as int : null,
      lastUpdatedBy: params['last_updated_by'] != null
          ? params['last_updated_by'] as int
          : null,
      typeId: params['type_id'] != null ? params['type_id'] as int : null,
      categoryId:
          params['category_id'] != null ? params['category_id'] as int : null,
      brandId: params['brand_id'] != null ? params['brand_id'] as int : null,
      typeName:
          params['type_name'] != null ? params['type_name'] as String : null,
      categoryName: params['category_name'] != null
          ? params['category_name'] as String
          : null,
      brandName:
          params['brand_name'] != null ? params['brand_name'] as String : null,
    );
  }
  int? id;
  String? name;
  int? hasSerial;
  int? isConsumable;
  int? unit;
  int? createdBy;
  int? lastUpdatedBy;
  int? typeId;
  int? categoryId;
  int? brandId;
  String? typeName;
  String? categoryName;
  String? brandName;

  Map<String, dynamic> toResponse() {
    return {
      'id': id,
      'name': name,
      'has_serial': hasSerial,
      'is_consumable': isConsumable,
      'unit': unit,
      'type': {
        'id': typeId,
        'name': typeName,
      },
      'brand': {
        'id': brandId,
        'name': brandName,
      },
      'category': {
        'id': categoryId,
        'name': categoryName,
      },
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        hasSerial,
        unit,
        createdBy,
        lastUpdatedBy,
        typeId,
        categoryId,
        brandId,
        typeName,
        isConsumable,
        categoryName,
        brandName,
      ];
}
