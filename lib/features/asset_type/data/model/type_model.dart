// ignore_for_file: public_member_api_docs, must_be_immutable,

import 'package:asset_management_api/features/asset_type/domain/entities/asset_type.dart';
import 'package:equatable/equatable.dart';

class AssetTypeModel extends Equatable {
  AssetTypeModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  // ignore: sort_constructors_first
  factory AssetTypeModel.fromDatabase(Map<String, dynamic> params) {
    return AssetTypeModel(
      id: params['id'] != null ? params['id'] as int : null,
      name: params['name'] != null ? params['name'] as String : null,
    );
  }

  // ignore: sort_constructors_first
  factory AssetTypeModel.fromEntity(AssetType params) {
    return AssetTypeModel(
      id: params.id,
      name: params.name,
    );
  }

  AssetType toEntity() {
    return AssetType(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
