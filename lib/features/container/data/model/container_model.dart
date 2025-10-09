// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/container/domain/entities/container.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ContainerModel extends Equatable {
  int? id;
  String? containerName;
  int? locationDetailId;
  String? locationDetailName;

  ContainerModel({
    this.id,
    this.containerName,
    this.locationDetailId,
    this.locationDetailName,
  });

  factory ContainerModel.fromDatabase(Map<String, dynamic> map) {
    return ContainerModel(
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

  factory ContainerModel.fromEntity(Container params) {
    return ContainerModel(
      id: params.id,
      containerName: params.containerName,
      locationDetailId: params.locationDetailId,
      locationDetailName: params.locationDetailName,
    );
  }

  Container toEntity() {
    return Container(
      id: id,
      containerName: containerName,
      locationDetailId: locationDetailId,
      locationDetailName: locationDetailName,
    );
  }

  @override
  List<Object?> get props =>
      [id, containerName, locationDetailId, locationDetailName];
}
