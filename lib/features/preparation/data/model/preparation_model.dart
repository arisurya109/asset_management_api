// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  int? temporaryLocationId;
  String? temporaryLocation;
  int? createdId;
  String? created;
  int? workerId;
  String? worker;
  int? approvedId;
  String? approved;
  int? totalBox;
  String? notes;
  DateTime? createdAt;

  PreparationModel({
    this.id,
    this.code,
    this.type,
    this.status,
    this.destinationId,
    this.destination,
    this.temporaryLocationId,
    this.temporaryLocation,
    this.createdId,
    this.created,
    this.workerId,
    this.worker,
    this.approvedId,
    this.approved,
    this.totalBox,
    this.notes,
    this.createdAt,
  });

  factory PreparationModel.fromJson(Map<String, dynamic> map) {
    return PreparationModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      destinationId:
          map['destination_id'] != null ? map['destination_id'] as int : null,
      destination:
          map['destination'] != null ? map['destination'] as String : null,
      temporaryLocationId: map['temporary_location_id'] != null
          ? map['temporary_location_id'] as int
          : null,
      temporaryLocation: map['temporary_location'] != null
          ? map['temporary_location'] as String
          : null,
      createdId: map['created_id'] != null ? map['created_id'] as int : null,
      created: map['created'] != null ? map['created'] as String : null,
      workerId: map['worker_id'] != null ? map['worker_id'] as int : null,
      worker: map['worker'] != null ? map['worker'] as String : null,
      approvedId: map['approved_id'] != null ? map['approved_id'] as int : null,
      approved: map['approved'] != null ? map['approved'] as String : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      createdAt:
          map['created_at'] != null ? map['created_at'] as DateTime : null,
    );
  }

  factory PreparationModel.fromEntity(Preparation params) {
    return PreparationModel(
      id: params.id,
      code: params.code,
      type: params.type,
      status: params.status,
      destination: params.destination,
      destinationId: params.destinationId,
      temporaryLocation: params.temporaryLocation,
      temporaryLocationId: params.temporaryLocationId,
      createdId: params.createdId,
      created: params.created,
      worker: params.worker,
      workerId: params.workerId,
      approved: params.approved,
      approvedId: params.approvedId,
      createdAt: params.createdAt,
      notes: params.notes,
      totalBox: params.totalBox,
    );
  }

  Preparation toEntity() {
    return Preparation(
      id: id,
      code: code,
      type: type,
      status: status,
      destination: destination,
      destinationId: destinationId,
      temporaryLocation: temporaryLocation,
      temporaryLocationId: temporaryLocationId,
      created: created,
      createdId: createdId,
      createdAt: createdAt,
      approved: approved,
      approvedId: approvedId,
      notes: notes,
      totalBox: totalBox,
      worker: worker,
      workerId: workerId,
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
      temporaryLocationId,
      temporaryLocation,
      createdId,
      created,
      workerId,
      worker,
      approvedId,
      approved,
      totalBox,
      notes,
      createdAt,
    ];
  }
}
