// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynam

import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationModel extends Equatable {
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
  String? afterShipped;

  PreparationModel({
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
    this.afterShipped,
  });

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'id': id,
      'preparation_code': preparationCode,
      'total_box': totalBox,
      'status': status,
      'notes': notes,
      'destination_id': destinationId,
      'assigned_id': assignedId,
      'temporary_location_id': temporaryLocationId,
      'created_by': createdById,
      'updated_by': updatedById,
      'approved_by': approvedById,
      'after_shipped': afterShipped,
    };
  }

  factory PreparationModel.fromDatabase(Map<String, dynamic> map) {
    return PreparationModel(
      id: map['id'] != null ? map['id'] as int : null,
      preparationCode: map['preparation_code'] != null
          ? map['preparation_code'] as String
          : null,
      destinationId:
          map['destination_id'] != null ? map['destination_id'] as int : null,
      destination:
          map['destination'] != null ? map['destination'] as String : null,
      assignedId: map['assigned_id'] != null ? map['assigned_id'] as int : null,
      assigned: map['assigned'] != null ? map['assigned'] as String : null,
      temporaryLocationId: map['temporary_location_id'] != null
          ? map['temporary_location_id'] as int
          : null,
      temporaryLocation: map['temporary_location'] != null
          ? map['temporary_location'] as String
          : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      createdById:
          map['created_by_id'] != null ? map['created_by_id'] as int : null,
      createdBy: map['created_by'] != null ? map['created_by'] as String : null,
      createdAt:
          map['created_at'] != null ? map['created_at'] as DateTime : null,
      updatedById:
          map['updated_by_id'] != null ? map['updated_by_id'] as int : null,
      updatedBy: map['updated_by'] != null ? map['updated_by'] as String : null,
      updatedAt:
          map['updated_at'] != null ? map['updated_at'] as DateTime : null,
      approvedById:
          map['approved_by_id'] != null ? map['approved_by_id'] as int : null,
      approvedBy:
          map['approved_by'] != null ? map['approved_by'] as String : null,
      approvedAt:
          map['approved_at'] != null ? map['approved_at'] as DateTime : null,
      afterShipped:
          map['after_shipped'] != null ? map['after_shipped'] as String : null,
    );
  }

  factory PreparationModel.fromEntity(Preparation params) {
    return PreparationModel(
      id: params.id,
      assigned: params.assigned,
      assignedId: params.assignedId,
      createdAt: params.createdAt,
      createdBy: params.createdBy,
      createdById: params.createdById,
      destination: params.destination,
      destinationId: params.destinationId,
      notes: params.notes,
      preparationCode: params.preparationCode,
      status: params.status,
      temporaryLocation: params.temporaryLocation,
      temporaryLocationId: params.temporaryLocationId,
      totalBox: params.totalBox,
      updatedAt: params.updatedAt,
      updatedBy: params.updatedBy,
      updatedById: params.updatedById,
      approvedAt: params.approvedAt,
      approvedBy: params.approvedBy,
      approvedById: params.approvedById,
      afterShipped: params.afterShipped,
    );
  }

  Preparation toEntity() {
    return Preparation(
      id: id,
      assigned: assigned,
      assignedId: assignedId,
      createdAt: createdAt,
      createdBy: createdBy,
      createdById: createdById,
      destination: destination,
      destinationId: destinationId,
      notes: notes,
      preparationCode: preparationCode,
      status: status,
      temporaryLocation: temporaryLocation,
      temporaryLocationId: temporaryLocationId,
      totalBox: totalBox,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
      updatedById: updatedById,
      approvedAt: approvedAt,
      approvedBy: approvedBy,
      approvedById: approvedById,
      afterShipped: afterShipped,
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
      approvedAt,
      approvedBy,
      approvedById,
      afterShipped,
    ];
  }
}
