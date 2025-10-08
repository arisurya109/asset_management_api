// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Location extends Equatable {
  int? id;
  int? areaId;
  String? areaName;
  String? areaInit;
  String? locationCode;
  String? locationName;
  String? locationInit;

  Location({
    this.id,
    this.areaId,
    this.areaName,
    this.areaInit,
    this.locationCode,
    this.locationName,
    this.locationInit,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'location_code': locationCode,
      'location_name': locationName,
      'location_init': locationInit,
      'area': {
        'id': areaId,
        'name': areaName,
        'init': areaInit,
      },
    };
  }

  factory Location.fromRequest(Map<String, dynamic> map) {
    return Location(
      id: map['id'] != null ? map['id'] as int : null,
      // ignore: avoid_dynamic_calls
      areaId: map['area']['id'] != null ? map['area']['id'] as int : null,
      areaName:
          // ignore: avoid_dynamic_calls
          map['area']['name'] != null ? map['area']['name'] as String : null,
      areaInit:
          // ignore: avoid_dynamic_calls
          map['area']['init'] != null ? map['area']['init'] as String : null,
      locationCode:
          map['location_code'] != null ? map['location_code'] as String : null,
      locationName:
          map['location_name'] != null ? map['location_name'] as String : null,
      locationInit: map['location__init'] != null
          ? map['location__init'] as String
          : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      areaId,
      areaName,
      areaInit,
      locationCode,
      locationName,
      locationInit,
    ];
  }
}
