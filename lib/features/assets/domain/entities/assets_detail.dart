// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetsDetail extends Equatable {
  int? id;
  String? movementType;
  String? fromLocation;
  String? toLocation;
  String? movementBy;
  DateTime? movementDate;
  String? referencesNumber;
  String? notes;

  AssetsDetail({
    this.id,
    this.movementType,
    this.fromLocation,
    this.toLocation,
    this.movementBy,
    this.movementDate,
    this.referencesNumber,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'movement_type': movementType,
      'from_location': fromLocation,
      'to_location': toLocation,
      'movement_by': movementBy,
      'movement_date': movementDate?.toIso8601String(),
      'references_number': referencesNumber,
      'notes': notes,
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      movementType,
      fromLocation,
      toLocation,
      movementBy,
      movementDate,
      referencesNumber,
      notes,
    ];
  }
}
