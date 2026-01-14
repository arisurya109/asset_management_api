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
  int? destinationCode;
  String? destinationInit;
  int? locationId;
  String? location;
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
    this.destinationCode,
    this.destinationInit,
    this.locationId,
    this.location,
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
      'destination': {
        'id': destinationId,
        'code': destinationCode,
        'init': destinationInit,
        'name': destination,
      },
      'location': {
        'id': locationId,
        'name': location,
      },
      'created': {'id': createdId, 'name': created},
      'worker': {'id': workerId, 'name': worker},
      'approved': {'id': approvedId, 'name': approved},
      'total_box': totalBox,
      'notes': notes,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      code,
      type,
      destinationCode,
      destinationInit,
      status,
      destinationId,
      destination,
      locationId,
      location,
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
