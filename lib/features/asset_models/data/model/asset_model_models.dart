// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors

import 'package:asset_management_api/features/asset_models/domain/entities/asset_model.dart';
import 'package:equatable/equatable.dart';

class AssetModelModels extends Equatable {
  AssetModelModels({
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

  factory AssetModelModels.fromDatabase(Map<String, dynamic> params) {
    return AssetModelModels(
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

  factory AssetModelModels.fromEntity(AssetModel params) {
    return AssetModelModels(
      id: params.id,
      name: params.name,
      hasSerial: params.hasSerial,
      isConsumable: params.isConsumable,
      unit: params.unit,
      createdBy: params.createdBy,
      lastUpdatedBy: params.lastUpdatedBy,
      typeId: params.typeId,
      categoryId: params.categoryId,
      brandId: params.brandId,
      typeName: params.typeName,
      categoryName: params.categoryName,
      brandName: params.brandName,
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
  String? code;

  AssetModel toEntity() {
    return AssetModel(
      id: id,
      name: name,
      hasSerial: hasSerial,
      isConsumable: isConsumable,
      unit: unit,
      createdBy: createdBy,
      lastUpdatedBy: lastUpdatedBy,
      typeId: typeId,
      categoryId: categoryId,
      brandId: brandId,
      typeName: typeName,
      categoryName: categoryName,
      brandName: brandName,
    );
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
