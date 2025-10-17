// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationRequest extends Equatable {
  int? id;
  int? purpose;
  int? createdBy;
  int? updatedBy;
  int? totalBox;
  String? status;

  PreparationRequest({
    this.id,
    this.purpose,
    this.createdBy,
    this.updatedBy,
    this.totalBox,
    this.status,
  });

  factory PreparationRequest.fromJson(Map<String, dynamic> map) {
    return PreparationRequest(
      id: map['id'] != null ? map['id'] as int : null,
      purpose: map['purpose'] != null ? map['purpose'] as int : null,
      createdBy: map['created_by'] != null ? map['created_by'] as int : null,
      updatedBy: map['updated_by'] != null ? map['updated_by'] as int : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      purpose,
      createdBy,
      updatedBy,
      totalBox,
      status,
    ];
  }
}
