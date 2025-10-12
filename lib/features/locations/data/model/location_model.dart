// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/locations/domain/entities/location.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LocationModel extends Equatable {
  int? id;
  String? name;

  LocationModel({
    this.id,
    this.name,
  });

  factory LocationModel.fromDatabase(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  factory LocationModel.fromEntity(Location params) {
    return LocationModel(
      id: params.id,
      name: params.name,
    );
  }

  Location toEntity() {
    return Location(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}

// ignore: must_be_immutable
class LocationDetailModel extends Equatable {
  int? id;
  String? name;
  String? code;
  String? init;
  int? locationId;
  String? locationName;

  LocationDetailModel({
    this.id,
    this.name,
    this.code,
    this.init,
    this.locationId,
    this.locationName,
  });

  factory LocationDetailModel.fromDatabase(Map<String, dynamic> map) {
    return LocationDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
      locationId: map['location_id'] != null ? map['location_id'] as int : null,
      locationName:
          map['location_name'] != null ? map['location_name'] as String : null,
    );
  }

  factory LocationDetailModel.fromEntity(LocationDetail params) {
    return LocationDetailModel(
      id: params.id,
      name: params.name,
      code: params.code,
      init: params.init,
      locationId: params.locationId,
      locationName: params.locationName,
    );
  }

  LocationDetail toEntity() {
    return LocationDetail(
      id: id,
      name: name,
      code: code,
      init: init,
      locationId: locationId,
      locationName: locationName,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      code,
      init,
      locationId,
      locationName,
    ];
  }
}

// ignore: must_be_immutable
class LocationTeamModel extends Equatable {
  int? id;
  String? name;
  int? locationDetailId;
  String? locationDetailName;

  LocationTeamModel({
    this.id,
    this.name,
    this.locationDetailId,
    this.locationDetailName,
  });

  factory LocationTeamModel.fromDatabase(Map<String, dynamic> map) {
    return LocationTeamModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      locationDetailId: map['location_detail_id'] != null
          ? map['location_detail_id'] as int
          : null,
      locationDetailName: map['location_detail_name'] != null
          ? map['location_detail_name'] as String
          : null,
    );
  }

  factory LocationTeamModel.fromEntity(LocationTeam params) {
    return LocationTeamModel(
      id: params.id,
      name: params.name,
      locationDetailId: params.locationDetailId,
      locationDetailName: params.locationDetailName,
    );
  }

  LocationTeam toEntity() {
    return LocationTeam(
      id: id,
      name: name,
      locationDetailId: locationDetailId,
      locationDetailName: locationDetailName,
    );
  }

  @override
  List<Object?> get props => [id, name, locationDetailId, locationDetailName];
}

// ignore: must_be_immutable
class LocationRackModel extends Equatable {
  int? id;
  String? name;
  int? locationTeamId;
  String? locationTeamName;

  LocationRackModel({
    this.id,
    this.name,
    this.locationTeamId,
    this.locationTeamName,
  });

  factory LocationRackModel.fromDatabase(Map<String, dynamic> map) {
    return LocationRackModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      locationTeamId: map['location_team_id'] != null
          ? map['location_team_id'] as int
          : null,
      locationTeamName: map['location_team_name'] != null
          ? map['location_team_name'] as String
          : null,
    );
  }

  factory LocationRackModel.fromEntity(LocationRack params) {
    return LocationRackModel(
      id: params.id,
      name: params.name,
      locationTeamId: params.locationTeamId,
      locationTeamName: params.locationTeamName,
    );
  }

  LocationRack toEntity() {
    return LocationRack(
      id: id,
      name: name,
      locationTeamId: locationTeamId,
      locationTeamName: locationTeamName,
    );
  }

  @override
  List<Object?> get props => [id, name, locationTeamId, locationTeamName];
}

// ignore: must_be_immutable
class LocationBoxModel extends Equatable {
  int? id;
  String? name;
  String? boxType;
  int? locationRackId;
  String? locationRackName;

  LocationBoxModel({
    this.id,
    this.name,
    this.boxType,
    this.locationRackId,
    this.locationRackName,
  });

  factory LocationBoxModel.fromDatabase(Map<String, dynamic> map) {
    return LocationBoxModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      boxType: map['box_type'] != null ? map['box_type'] as String : null,
      locationRackId: map['location_rack_id'] != null
          ? map['location_rack_id'] as int
          : null,
      locationRackName: map['location_rack_name'] != null
          ? map['location_rack_name'] as String
          : null,
    );
  }

  factory LocationBoxModel.fromEntity(LocationBox params) {
    return LocationBoxModel(
      id: params.id,
      name: params.name,
      boxType: params.boxType,
      locationRackId: params.locationRackId,
      locationRackName: params.locationRackName,
    );
  }

  LocationBox toEntity() {
    return LocationBox(
      id: id,
      name: name,
      boxType: boxType,
      locationRackId: locationRackId,
      locationRackName: locationRackName,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      boxType,
      locationRackId,
      locationRackName,
    ];
  }
}
