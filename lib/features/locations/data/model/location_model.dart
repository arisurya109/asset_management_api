// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/locations/domain/entities/location.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LocationModel extends Equatable {
  int? id;
  int? areaId;
  String? areaName;
  String? areaInit;
  String? locationCode;
  String? locationName;
  String? locationInit;

  LocationModel({
    this.id,
    this.areaId,
    this.areaName,
    this.areaInit,
    this.locationCode,
    this.locationName,
    this.locationInit,
  });

  factory LocationModel.fromDatabase(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] != null ? map['id'] as int : null,
      areaId: map['area_id'] != null ? map['area_id'] as int : null,
      areaName: map['area_name'] != null ? map['area_name'] as String : null,
      areaInit: map['area_init'] != null ? map['area_init'] as String : null,
      locationCode:
          map['location_code'] != null ? map['location_code'] as String : null,
      locationName:
          map['location_name'] != null ? map['location_name'] as String : null,
      locationInit: map['location__init'] != null
          ? map['location__init'] as String
          : null,
    );
  }

  factory LocationModel.fromEntity(Location params) {
    return LocationModel(
      id: params.id,
      areaId: params.areaId,
      areaInit: params.areaInit,
      areaName: params.areaName,
      locationCode: params.locationCode,
      locationInit: params.locationInit,
      locationName: params.locationName,
    );
  }

  Location toEntity() {
    return Location(
      id: id,
      areaId: areaId,
      areaInit: areaInit,
      areaName: areaName,
      locationCode: locationCode,
      locationInit: locationInit,
      locationName: locationName,
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
