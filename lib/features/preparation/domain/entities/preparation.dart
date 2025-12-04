// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Preparation extends Equatable {
  int? id;
  String? preparationCode;
  int? destinationId;
  String? destination;
  int? assignedId;
  String? assigned;
  int? temporaryLocationId;
  String? temporaryLocation;
  int? totalBox;
  String? status;
  String? notes;
  int? createdById;
  String? createdBy;
  DateTime? createdAt;
  int? updatedById;
  String? updatedBy;
  DateTime? updatedAt;
  int? approvedById;
  String? approvedBy;
  DateTime? approvedAt;
  String? assetStatusAfter;
  String? assetConditionAfter;

  Preparation({
    this.id,
    this.preparationCode,
    this.destinationId,
    this.destination,
    this.assignedId,
    this.assigned,
    this.temporaryLocationId,
    this.temporaryLocation,
    this.totalBox,
    this.status,
    this.notes,
    this.createdById,
    this.createdBy,
    this.createdAt,
    this.updatedById,
    this.updatedBy,
    this.updatedAt,
    this.approvedById,
    this.approvedBy,
    this.approvedAt,
    this.assetStatusAfter,
    this.assetConditionAfter,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'preparation_code': preparationCode,
      'total_box': totalBox,
      'status': status,
      'notes': notes,
      'destination': {
        'id': destinationId,
        'name': destination,
      },
      'assigned': {
        'id': assignedId,
        'name': assigned,
      },
      'temporary_location': {
        'id': temporaryLocationId,
        'name': temporaryLocation,
      },
      'created_by': {
        'id': createdById,
        'name': createdBy,
      },
      'updated_by': {
        'id': updatedById,
        'name': updatedBy,
      },
      'approved_by': {
        'id': approvedById,
        'name': approvedBy,
      },
      'asset_after': {
        'status': assetStatusAfter,
        'condition': assetConditionAfter,
      },
    };
  }

  factory Preparation.fromJson(Map<String, dynamic> map) {
    return Preparation(
      id: map['id'] != null ? map['id'] as int? : null,
      preparationCode: map['preparation_code'] != null
          ? map['preparation_code'] as String?
          : null,
      destinationId:
          map['destination_id'] != null ? map['destination_id'] as int? : null,
      assignedId:
          map['assigned_id'] != null ? map['assigned_id'] as int? : null,
      temporaryLocationId: map['temporary_location_id'] != null
          ? map['temporary_location_id'] as int?
          : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int? : null,
      status: map['status'] != null ? map['status'] as String? : null,
      notes: map['notes'] != null ? map['notes'] as String? : null,
      createdById:
          map['created_by_id'] != null ? map['created_by_id'] as int? : null,
      updatedById:
          map['updated_by_id'] != null ? map['updated_by_id'] as int? : null,
      approvedById:
          map['approved_by_id'] != null ? map['approved_by_id'] as int? : null,
      assetConditionAfter: map['asset_condition_after'] != null
          ? map['asset_condition_after'] as String?
          : null,
      assetStatusAfter: map['asset_status_after'] != null
          ? map['asset_status_after'] as String?
          : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      preparationCode,
      destinationId,
      destination,
      assignedId,
      assigned,
      temporaryLocationId,
      temporaryLocation,
      totalBox,
      status,
      notes,
      createdById,
      createdBy,
      createdAt,
      updatedById,
      updatedBy,
      updatedAt,
      approvedBy,
      approvedById,
      assetConditionAfter,
      assetStatusAfter,
      approvedAt,
    ];
  }
}
