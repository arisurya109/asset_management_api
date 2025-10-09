// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynam

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LocationDetail extends Equatable {
  int? id;
  int? locationId;
  String? locationName;
  String? locationCode;
  String? locationDetailName;

  LocationDetail({
    this.id,
    this.locationId,
    this.locationName,
    this.locationCode,
    this.locationDetailName,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'location_detail_name': locationDetailName,
      'location': {
        'id': locationId,
        'name': locationName,
        'code': locationCode,
      },
    };
  }

  factory LocationDetail.fromRequest(Map<String, dynamic> map) {
    return LocationDetail(
      id: map['id'] != null ? map['id'] as int : null,
      locationId: map['location_id'] != null ? map['location_id'] as int : null,
      locationName:
          map['location_name'] != null ? map['location_name'] as String : null,
      locationCode:
          map['location_code'] != null ? map['location_code'] as String : null,
      locationDetailName: map['location_detail_name'] != null
          ? map['location_detail_name'] as String
          : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      locationId,
      locationName,
      locationCode,
      locationDetailName,
    ];
  }
}
