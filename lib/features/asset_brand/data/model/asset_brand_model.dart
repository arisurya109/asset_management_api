// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors

import 'package:asset_management_api/features/asset_brand/domain/entities/asset_brand.dart';
import 'package:equatable/equatable.dart';

class AssetBrandModel extends Equatable {
  AssetBrandModel({
    this.id,
    this.name,
    this.init,
  });

  factory AssetBrandModel.fromDatabase(Map<String, dynamic> map) {
    return AssetBrandModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
    );
  }

  factory AssetBrandModel.fromEntity(AssetBrand params) {
    return AssetBrandModel(
      id: params.id,
      name: params.name,
      init: params.init,
    );
  }
  int? id;
  String? name;
  String? init;

  AssetBrand toEntity() {
    return AssetBrand(id: id, name: name, init: init);
  }

  @override
  List<Object?> get props => [id, name, init];
}
