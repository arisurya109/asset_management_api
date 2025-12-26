// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynam

import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationModel extends Equatable {
  int? id;
  String? code;
  String? type;
  String? status;
  int? destinationId;
  String? destination;
  int? createdId;
  String? createdBy;
  int? workerId;
  String? workerBy;
  int? approvedId;
  String? approvedBy;
  int? locationId;
  String? location;
  int? totalBox;
  String? notes;
  String? createdAt;

  PreparationModel({
    this.id,
    this.code,
    this.type,
    this.status,
    this.destinationId,
    this.destination,
    this.createdId,
    this.createdBy,
    this.workerId,
    this.workerBy,
    this.approvedId,
    this.approvedBy,
    this.locationId,
    this.location,
    this.totalBox,
    this.notes,
    this.createdAt,
  });

  // Map<String, dynamic> toDatabase() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'preparation_code': preparationCode,
  //     'total_box': totalBox,
  //     'status': status,
  //     'notes': notes,
  //     'destination_id': destinationId,
  //     'assigned_id': assignedId,
  //     'temporary_location_id': temporaryLocationId,
  //     'created_by': createdById,
  //     'updated_by': updatedById,
  //     'approved_by': approvedById,
  //     'after_shipped': afterShipped,
  //   };
  // }

  factory PreparationModel.fromDatabase(Map<String, dynamic> map) {
    return PreparationModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      destinationId:
          map['destination_id'] != null ? map['destination_id'] as int : null,
      destination:
          map['destination'] != null ? map['destination'] as String : null,
      createdId: map['created_id'] != null ? map['created_id'] as int : null,
      createdBy: map['created_by'] != null ? map['created_by'] as String : null,
      workerId: map['worker_id'] != null ? map['worker_id'] as int : null,
      workerBy: map['worker_by'] != null ? map['worker_by'] as String : null,
      approvedId: map['approved_id'] != null ? map['approved_id'] as int : null,
      approvedBy:
          map['approved_by'] != null ? map['approved_by'] as String : null,
      locationId: map['location_id'] != null ? map['location_id'] as int : null,
      location: map['location'] != null ? map['location'] as String : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      createdAt: map['created_at'] != null
          ? (map['created_at'] as DateTime).toIso8601String()
          : null,
    );
  }

  factory PreparationModel.fromEntity(Preparation params) {
    return PreparationModel(
      id: params.id,
      code: params.code,
      status: params.status,
      type: params.type,
      createdId: params.createdId,
      createdBy: params.createdBy,
      workerId: params.workerId,
      workerBy: params.workerBy,
      approvedId: params.approvedId,
      approvedBy: params.approvedBy,
      destinationId: params.destinationId,
      destination: params.destination,
      locationId: params.locationId,
      location: params.location,
      notes: params.notes,
      totalBox: params.totalBox,
      createdAt: params.createdAt,
    );
  }

  Preparation toEntity() {
    return Preparation(
      id: id,
      code: code,
      status: status,
      type: type,
      createdId: createdId,
      createdBy: createdAt,
      workerBy: workerBy,
      workerId: workerId,
      approvedBy: approvedBy,
      approvedId: approvedId,
      destination: destination,
      destinationId: destinationId,
      location: location,
      locationId: locationId,
      notes: notes,
      createdAt: createdAt,
      totalBox: totalBox,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      code,
      type,
      status,
      destinationId,
      destination,
      createdId,
      createdBy,
      workerId,
      workerBy,
      approvedId,
      approvedBy,
      locationId,
      location,
      totalBox,
      notes,
      createdAt,
    ];
  }
}
