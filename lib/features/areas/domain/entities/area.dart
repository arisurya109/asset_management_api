// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Area extends Equatable {
  int? id;
  String? areaName;
  String? areaInit;

  Area({
    this.id,
    this.areaName,
    this.areaInit,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'area_name': areaName,
      'area_init': areaInit,
    };
  }

  @override
  List<Object?> get props => [id, areaName, areaInit];
}
