// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetType extends Equatable {
  int? id;
  int? brandId;
  String? brandName;
  String? typeName;

  AssetType({
    this.id,
    this.brandId,
    this.brandName,
    this.typeName,
  });

  @override
  List<Object?> get props => [id, brandId, brandName, typeName];

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'type_name': typeName,
      'brand': {
        'id': brandId,
        'name': brandName,
      },
    };
  }

  factory AssetType.fromMap(Map<String, dynamic> map) {
    return AssetType(
      id: map['id'] != null ? map['id'] as int : null,
      typeName: map['type_name'] != null ? map['type_name'] as String : null,
      brandId: map['brand']['id'] != null ? map['brand']['id'] as int : null,
      brandName:
          map['brand']['name'] != null ? map['brand']['name'] as String : null,
    );
  }
}
