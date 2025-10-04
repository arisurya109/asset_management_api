// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/assets/domain/entities/asset.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetModel extends Equatable {
  int? id;
  String? assetCode;
  String? assetName;
  String? assetInit;

  AssetModel({
    this.id,
    this.assetCode,
    this.assetName,
    this.assetInit,
  });

  @override
  List<Object?> get props => [id, assetCode, assetName, assetInit];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'asset_code': assetCode,
      'asset_name': assetName,
      'asset_init': assetInit,
    };
  }

  Asset toEntity() {
    return Asset(
      id: id,
      assetCode: assetCode,
      assetInit: assetInit,
      assetName: assetName,
    );
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map['id'] != null ? map['id'] as int : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      assetName: map['asset_name'] != null ? map['asset_name'] as String : null,
      assetInit: map['asset_init'] != null ? map['asset_init'] as String : null,
    );
  }
  factory AssetModel.fromEntity(Asset params) {
    return AssetModel(
      id: params.id,
      assetCode: params.assetCode,
      assetName: params.assetName,
      assetInit: params.assetInit,
    );
  }
}
