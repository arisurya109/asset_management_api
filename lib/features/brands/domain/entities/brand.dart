// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Brand extends Equatable {
  int? id;
  int? assetId;
  String? assetName;
  String? brandCode;
  String? brandName;

  Brand({
    this.id,
    this.assetName,
    this.assetId,
    this.brandCode,
    this.brandName,
  });

  @override
  List<Object?> get props => [id, assetId, assetName, brandCode, brandName];

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'brand_code': brandCode,
      'brand_name': brandName,
      'asset': {
        'id': assetId,
        'name': assetName,
      },
    };
  }

  factory Brand.fromRequest(Map<String, dynamic> map) {
    return Brand(
      id: map['id'] != null ? map['id'] as int : null,
      // ignore: avoid_dynamic_calls
      assetId: map['asset']['id'] != null ? map['asset']['id'] as int : null,
      assetName:
          // ignore: avoid_dynamic_calls
          map['asset']['name'] != null ? map['asset']['name'] as String : null,
      brandCode: map['brand_code'] != null ? map['brand_code'] as String : null,
      brandName: map['brand_name'] != null ? map['brand_name'] as String : null,
    );
  }
}
