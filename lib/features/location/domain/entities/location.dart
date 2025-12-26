// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Location extends Equatable {
  int? id;
  String? name;
  String? locationType;
  String? boxType;
  int? code;
  String? init;
  int? parentId;
  String? parentName;

  Location({
    this.id,
    this.name,
    this.locationType,
    this.boxType,
    this.code,
    this.init,
    this.parentId,
    this.parentName,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code.toString(),
      'init': init,
      'location_type': locationType,
      'box_type': boxType,
      'parent': {
        'id': parentId,
        'name': parentName,
      },
    };
  }

  factory Location.fromRequest(Map<String, dynamic> map) {
    return Location(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      locationType:
          map['location_type'] != null ? map['location_type'] as String : null,
      boxType: map['box_type'] != null ? map['box_type'] as String : null,
      code: map['code'] != null ? int.tryParse(map['code'] as String) : null,
      init: map['init'] != null ? map['init'] as String : null,
      parentId: map['parent_id'] != null ? map['parent_id'] as int : null,
      parentName:
          map['parent_name'] != null ? map['parent_name'] as String : null,
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
