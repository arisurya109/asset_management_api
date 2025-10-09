// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Container extends Equatable {
  int? id;
  String? containerName;
  int? locationDetailId;
  String? locationDetailName;

  Container({
    this.id,
    this.containerName,
    this.locationDetailId,
    this.locationDetailName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'container_name': containerName,
      'location_detail': {
        'id': locationDetailId,
        'name': locationDetailName,
      },
    };
  }

  factory Container.fromMap(Map<String, dynamic> map) {
    return Container(
      id: map['id'] != null ? map['id'] as int : null,
      containerName: map['container_name'] != null
          ? map['container_name'] as String
          : null,
      locationDetailId: map['location_detail_id'] != null
          ? map['location_detail_id'] as int
          : null,
      locationDetailName: map['location_detail_name'] != null
          ? map['location_detail_name'] as String
          : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, containerName, locationDetailId, locationDetailName];
}
