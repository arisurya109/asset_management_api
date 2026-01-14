// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:equatable/equatable.dart';

class PreparationRequest extends Equatable {
  int? id;
  String? type;
  String? status;
  int? destination;
  int? created;
  int? worker;
  int? approved;
  String? notes;

  PreparationRequest({
    this.id,
    this.type,
    this.status,
    this.destination,
    this.created,
    this.worker,
    this.approved,
    this.notes,
  });

  factory PreparationRequest.jsonCreate(Map<String, dynamic> map) {
    return PreparationRequest(
      type: map['type'] != null ? map['type'] as String : null,
      destination:
          map['destination'] != null ? map['destination'] as int : null,
      created: map['created'] != null ? map['created'] as int : null,
      worker: map['worker'] != null ? map['worker'] as int : null,
      approved: map['approved'] != null ? map['approved'] as int : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  factory PreparationRequest.jsonUpdate(Map<String, dynamic> map) {
    return PreparationRequest(
      id: map['id'] != null ? map['id'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String? validateCreateRequest() {
    if (!type.isFilled()) {
      return 'Type cannot be empty';
    } else if (destination == null) {
      return 'Destination cannot be empty';
    } else if (created == null) {
      return 'Created cannot be empty';
    } else if (approved == null) {
      return 'Approved cannot be empty';
    } else if (worker == null) {
      return 'Worker cannot be empty';
    } else {
      return null;
    }
  }

  String? validateUpdateRequest() {
    if (id == null) {
      return 'Id cannot be empty';
    } else if (!status.isFilled()) {
      return 'Status cannot be empty';
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props {
    return [
      id,
      type,
      status,
      destination,
      created,
      worker,
      approved,
      notes,
    ];
  }
}
