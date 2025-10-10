// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructor

import 'package:asset_management_api/features/asset_categories/domain/entities/asset_category.dart';
import 'package:equatable/equatable.dart';

class AssetCategoryModel extends Equatable {
  AssetCategoryModel({
    this.id,
    this.name,
    this.init,
  });

  factory AssetCategoryModel.fromDatabase(Map<String, dynamic> map) {
    return AssetCategoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
    );
  }

  factory AssetCategoryModel.fromEntity(AssetCategory params) {
    return AssetCategoryModel(
      id: params.id,
      name: params.name,
      init: params.init,
    );
  }
  int? id;
  String? name;
  String? init;

  AssetCategory toEntity() {
    return AssetCategory(
      id: id,
      name: name,
      init: init,
    );
  }

  @override
  List<Object?> get props => [id, name, init];
}
