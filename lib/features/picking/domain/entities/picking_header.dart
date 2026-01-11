// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingHeader extends Equatable {
  int? id;
  String? code;
  String? type;
  String? status;
  int? destinationId;
  String? destination;
  int? temporaryLocationId;
  String? temporaryLocation;
  int? totalBox;
  String? notes;
  int? totalItems;
  int? totalQuantiy;

  PickingHeader({
    this.id,
    this.code,
    this.type,
    this.status,
    this.destinationId,
    this.destination,
    this.temporaryLocationId,
    this.temporaryLocation,
    this.totalBox,
    this.notes,
    this.totalItems,
    this.totalQuantiy,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'status': status,
      'destination': {'id': destinationId, 'name': destination},
      'temporary_location': {
        'id': temporaryLocationId,
        'name': temporaryLocation,
      },
      'total_box': totalBox,
      'total_items': totalItems,
      'total_quantity': totalQuantiy,
      'notes': notes,
    };
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
      totalBox,
      notes,
    ];
  }
}
