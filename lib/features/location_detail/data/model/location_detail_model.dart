// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynam

import 'package:asset_management_api/features/location_detail/domain/entities/location_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LocationDetailModel extends Equatable {
  int? id;
  int? locationId;
  String? locationName;
  String? locationCode;
  String? locationDetailName;

  LocationDetailModel({
    this.id,
    this.locationId,
    this.locationName,
    this.locationCode,
    this.locationDetailName,
  });

  factory LocationDetailModel.fromDatabase(Map<String, dynamic> map) {
    return LocationDetailModel(
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

  factory LocationDetailModel.fromEntity(LocationDetail params) {
    return LocationDetailModel(
      id: params.id,
      locationDetailName: params.locationDetailName,
      locationName: params.locationName,
      locationCode: params.locationCode,
      locationId: params.locationId,
    );
  }

  LocationDetail toEntity() {
    return LocationDetail(
      id: id,
      locationDetailName: locationDetailName,
      locationName: locationName,
      locationId: locationId,
      locationCode: locationCode,
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
