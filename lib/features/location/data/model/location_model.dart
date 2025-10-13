// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/location/domain/entities/location.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LocationModel extends Equatable {
  int? id;
  String? name;
  String? locationType;
  String? boxType;
  String? code;
  String? init;
  int? parentId;
  String? parentName;

  LocationModel({
    this.id,
    this.name,
    this.locationType,
    this.boxType,
    this.code,
    this.init,
    this.parentId,
    this.parentName,
  });

  factory LocationModel.fromDatabase(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      locationType:
          map['location_type'] != null ? map['location_type'] as String : null,
      boxType: map['box_type'] != null ? map['box_type'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
      parentId: map['parent_id'] != null ? map['parent_id'] as int : null,
      parentName:
          map['parent_name'] != null ? map['parent_name'] as String : null,
    );
  }

  factory LocationModel.fromEntity(Location params) {
    return LocationModel(
      id: params.id,
      name: params.name,
      locationType: params.locationType,
      boxType: params.boxType,
      code: params.code,
      init: params.init,
      parentId: params.parentId,
      parentName: params.parentName,
    );
  }

  Location toEntity() {
    return Location(
      id: id,
      name: name,
      init: init,
      code: code,
      boxType: boxType,
      locationType: locationType,
      parentId: parentId,
      parentName: parentName,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      locationType,
      boxType,
      code,
      init,
      parentId,
      parentName,
    ];
  }
}
