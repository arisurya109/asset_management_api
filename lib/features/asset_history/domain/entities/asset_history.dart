// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetHistory extends Equatable {
  String? movementType;
  String? fromLocation;
  String? toLocation;
  String? movementBy;
  DateTime? movementDate;
  String? referencesNumber;
  String? notes;

  AssetHistory({
    this.movementType,
    this.fromLocation,
    this.toLocation,
    this.movementBy,
    this.movementDate,
    this.referencesNumber,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
