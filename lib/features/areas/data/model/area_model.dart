// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/areas/domain/entities/area.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AreaModel extends Equatable {
  int? id;
  String? areaName;
  String? areaInit;

  AreaModel({
    this.id,
    this.areaName,
    this.areaInit,
  });

  @override
  List<Object?> get props => [id, areaName, areaInit];

  factory AreaModel.fromDatabase(Map<String, dynamic> map) {
    return AreaModel(
      id: map['id'] != null ? map['id'] as int : null,
      areaName: map['area_name'] != null ? map['area_name'] as String : null,
      areaInit: map['area_init'] != null ? map['area_init'] as String : null,
    );
  }

  Area toEntity() {
    return Area(
      id: id,
      areaInit: areaInit,
      areaName: areaName,
    );
  }
}
