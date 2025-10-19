// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/asset_history/domain/entities/asset_history.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetHistoryModel extends Equatable {
  String? movementType;
  String? fromLocation;
  String? toLocation;
  String? movementBy;
  DateTime? movementDate;
  String? referencesNumber;
  String? notes;

  AssetHistoryModel({
    this.movementType,
    this.fromLocation,
    this.toLocation,
    this.movementBy,
    this.movementDate,
    this.referencesNumber,
    this.notes,
  });

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

  factory AssetHistoryModel.fromDatabase(Map<String, dynamic> map) {
    return AssetHistoryModel(
      movementType:
          map['movement_type'] != null ? map['movement_type'] as String : null,
      fromLocation:
          map['from_location'] != null ? map['from_location'] as String : null,
      toLocation:
          map['to_location'] != null ? map['to_location'] as String : null,
      movementBy:
          map['movement_by'] != null ? map['movement_by'] as String : null,
      movementDate: map['movement_date'] != null
          ? map['movement_date'] as DateTime
          : null,
      referencesNumber: map['references_number'] != null
          ? map['references_number'] as String
          : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  AssetHistory toEntity() {
    return AssetHistory(
      movementType: movementType,
      fromLocation: fromLocation,
      toLocation: toLocation,
      movementBy: movementBy,
      movementDate: movementDate,
      referencesNumber: referencesNumber,
      notes: notes,
    );
  }
}
