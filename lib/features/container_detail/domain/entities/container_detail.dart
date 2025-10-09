// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ContainerDetail extends Equatable {
  int? id;
  String? containerDetailName;
  int? containerId;
  String? containerName;

  ContainerDetail({
    this.id,
    this.containerDetailName,
    this.containerId,
    this.containerName,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'container_detail_name': containerDetailName,
      'container': {
        'id': containerId,
        'name': containerName,
      },
    };
  }

  factory ContainerDetail.fromRequest(Map<String, dynamic> map) {
    return ContainerDetail(
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

  @override
  List<Object?> get props =>
      [id, containerDetailName, containerId, containerName];
}
