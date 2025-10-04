// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Asset extends Equatable {
  int? id;
  String? assetCode;
  String? assetName;
  String? assetInit;

  Asset({
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

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'] != null ? map['id'] as int : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      assetName: map['asset_name'] != null ? map['asset_name'] as String : null,
      assetInit: map['asset_init'] != null ? map['asset_init'] as String : null,
    );
  }
}
