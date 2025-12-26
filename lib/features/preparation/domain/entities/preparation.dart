// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Preparation extends Equatable {
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

  Preparation({
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'type': type,
      'status': status,
      'destination': {
        'id': destinationId,
        'name': destination,
      },
      'created_by': {
        'id': createdId,
        'name': createdBy,
      },
      'worker_by': {
        'id': workerId,
        'name': workerBy,
      },
      'approved_by': {
        'id': approvedId,
        'name': approvedBy,
      },
      'location': {
        'id': locationId,
        'name': location,
      },
      'total_box': totalBox,
      'notes': notes,
      'created_at': createdAt,
    };
  }

  factory Preparation.fromJson(Map<String, dynamic> map) {
    return Preparation(
      id: map['id'] != null ? map['id'] as int? : null,
      code: map['code'] != null ? map['code'] as String? : null,
      destinationId:
          map['destination_id'] != null ? map['destination_id'] as int? : null,
      workerId: map['worker_id'] != null ? map['worker_id'] as int? : null,
      locationId:
          map['location_id'] != null ? map['location_id'] as int? : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int? : null,
      status: map['status'] != null ? map['status'] as String? : null,
      notes: map['notes'] != null ? map['notes'] as String? : null,
      createdId: map['created_id'] != null ? map['created_id'] as int? : null,
      approvedId:
          map['approved_id'] != null ? map['approved_id'] as int? : null,
      type: map['type'] != null ? map['type'] as String? : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      code,
      status,
      type,
      destinationId,
      destination,
      totalBox,
      status,
      notes,
      createdBy,
      createdId,
      approvedBy,
      createdId,
      workerId,
      workerBy,
      createdAt,
    ];
  }
}
