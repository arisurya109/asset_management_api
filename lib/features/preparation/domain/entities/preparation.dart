// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Preparation extends Equatable {
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

  Preparation({
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'type': type,
      'status': status,
      'destination': {'id': destinationId, 'name': destination},
      'temporary_location': {
        'id': temporaryLocationId,
        'name': temporaryLocation,
      },
      'created': {'id': createdId, 'name': created},
      'worker': {'id': workerId, 'name': worker},
      'approved': {'id': approvedId, 'name': approved},
      'total_box': totalBox,
      'notes': notes,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  String? validateCreatePreparation() {
    const validTypes = ['INTERNAL', 'EXTERNAL'];

    if (type == null || type!.isEmpty || !validTypes.contains(type)) {
      return 'Type is not valid';
    }

    if (destinationId == null) {
      return 'Destination cannot be empty';
    }

    if (workerId == null) {
      return 'Worker cannot be empty';
    }

    if (approvedId == null) {
      return 'Approved cannot be empty';
    }

    if (workerId == approvedId) {
      return 'Workers and approved users cannot be the same person.';
    }

    return null;
  }

  factory Preparation.fromJson(Map<String, dynamic> map) {
    return Preparation(
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
