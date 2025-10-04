// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/brands/domain/entities/brand.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class BrandModel extends Equatable {
  int? id;
  int? assetId;
  String? assetName;
  String? brandCode;
  String? brandName;

  BrandModel({
    this.id,
    this.assetName,
    this.assetId,
    this.brandCode,
    this.brandName,
  });

  @override
  List<Object?> get props => [id, assetId, assetName, brandCode, brandName];

  factory BrandModel.fromDatabase(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] != null ? map['id'] as int : null,
      assetId: map['asset_id'] != null ? map['asset_id'] as int : null,
      assetName: map['asset_name'] != null ? map['asset_name'] as String : null,
      brandCode: map['brand_code'] != null ? map['brand_code'] as String : null,
      brandName: map['brand_name'] != null ? map['brand_name'] as String : null,
    );
  }

  factory BrandModel.fromEntity(Brand params) {
    return BrandModel(
      id: params.id,
      assetId: params.assetId,
      assetName: params.assetName,
      brandCode: params.brandCode,
      brandName: params.brandName,
    );
  }

  Brand toEntity() {
    return Brand(
      id: id,
      assetId: assetId,
      assetName: assetName,
      brandCode: brandCode,
      brandName: brandName,
    );
  }
}
