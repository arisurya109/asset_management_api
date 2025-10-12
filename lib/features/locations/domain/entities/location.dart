// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Location extends Equatable {
  int? id;
  String? name;

  Location({
    this.id,
    this.name,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Location.fromRequest(Map<String, dynamic> map) {
    return Location(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  @override
  List<Object?> get props => [id, name];
}

// ignore: must_be_immutable
class LocationDetail extends Equatable {
  int? id;
  String? name;
  String? code;
  String? init;
  int? locationId;
  String? locationName;

  LocationDetail({
    this.id,
    this.name,
    this.code,
    this.init,
    this.locationId,
    this.locationName,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'init': init,
      'location': {'id': id, 'name': locationName},
    };
  }

  factory LocationDetail.fromRequest(Map<String, dynamic> map) {
    return LocationDetail(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
      locationId: map['location_id'] != null ? map['location_id'] as int : null,
      locationName:
          map['location_name'] != null ? map['location_name'] as String : null,
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
class LocationTeam extends Equatable {
  int? id;
  String? name;
  int? locationDetailId;
  String? locationDetailName;

  LocationTeam({
    this.id,
    this.name,
    this.locationDetailId,
    this.locationDetailName,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'location_detail': {
        'id': locationDetailId,
        'name': locationDetailName,
      },
    };
  }

  factory LocationTeam.fromRequest(Map<String, dynamic> map) {
    return LocationTeam(
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

  @override
  List<Object?> get props => [id, name, locationDetailId, locationDetailName];
}

// ignore: must_be_immutable
class LocationRack extends Equatable {
  int? id;
  String? name;
  int? locationTeamId;
  String? locationTeamName;

  LocationRack({
    this.id,
    this.name,
    this.locationTeamId,
    this.locationTeamName,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'location_team': {
        'id': locationTeamId,
        'name': locationTeamName,
      }
    };
  }

  factory LocationRack.fromRequest(Map<String, dynamic> map) {
    return LocationRack(
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

  @override
  List<Object?> get props => [id, name, locationTeamId, locationTeamName];
}

// ignore: must_be_immutable
class LocationBox extends Equatable {
  int? id;
  String? name;
  String? boxType;
  int? locationRackId;
  String? locationRackName;

  LocationBox({
    this.id,
    this.name,
    this.boxType,
    this.locationRackId,
    this.locationRackName,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'box_type': boxType,
      'location_rack': {'id': locationRackId, 'name': locationRackName},
    };
  }

  factory LocationBox.fromRequest(Map<String, dynamic> map) {
    return LocationBox(
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
