// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/container_detail/domain/entities/container_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ContainerDetailModel extends Equatable {
  int? id;
  String? containerDetailName;
  int? containerId;
  String? containerName;

  ContainerDetailModel({
    this.id,
    this.containerDetailName,
    this.containerId,
    this.containerName,
  });

  ContainerDetail toEntity() {
    return ContainerDetail(
      id: id,
      containerDetailName: containerDetailName,
      containerId: containerId,
      containerName: containerName,
    );
  }

  factory ContainerDetailModel.fromDatabase(Map<String, dynamic> map) {
    return ContainerDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      containerDetailName: map['container_detail_name'] != null
          ? map['container_detail_name'] as String
          : null,
      containerId:
          map['container_id'] != null ? map['container_id'] as int : null,
      containerName: map['container_name'] != null
          ? map['container_name'] as String
          : null,
    );
  }

  factory ContainerDetailModel.fromEntity(ContainerDetail params) {
    return ContainerDetailModel(
      id: params.id,
      containerDetailName: params.containerDetailName,
      containerId: params.containerId,
      containerName: params.containerName,
    );
  }

  @override
  List<Object?> get props =>
      [id, containerDetailName, containerId, containerName];
}
