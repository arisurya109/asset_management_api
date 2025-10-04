// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls

import 'package:asset_management_api/features/asset_types/domain/entities/asset_type.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetTypeModel extends Equatable {
  int? id;
  int? brandId;
  String? brandName;
  String? typeName;

  AssetTypeModel({
    this.id,
    this.brandId,
    this.brandName,
    this.typeName,
  });

  @override
  List<Object?> get props => [id, brandId, brandName, typeName];

  AssetType toEntity() {
    return AssetType(
      id: id,
      typeName: typeName,
      brandId: brandId,
      brandName: brandName,
    );
  }

  factory AssetTypeModel.fromMap(Map<String, dynamic> map) {
    return AssetTypeModel(
      id: map['id'] != null ? map['id'] as int : null,
      typeName: map['type_name'] != null ? map['type_name'] as String : null,
      brandId: map['brand_id'] != null ? map['brand_id'] as int : null,
      brandName: map['brand_name'] != null ? map['brand_name'] as String : null,
    );
  }

  factory AssetTypeModel.fromEntity(AssetType params) {
    return AssetTypeModel(
      id: params.id,
      typeName: params.typeName,
      brandId: params.brandId,
      brandName: params.brandName,
    );
  }
}
