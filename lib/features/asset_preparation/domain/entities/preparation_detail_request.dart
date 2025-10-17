// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetailRequest extends Equatable {
  int? preparationId;
  int? assetId;
  int? quantity;
  int? rackId;
  int? boxId;
  int? preparedBy;

  PreparationDetailRequest({
    this.preparationId,
    this.assetId,
    this.quantity,
    this.rackId,
    this.boxId,
    this.preparedBy,
  });

  factory PreparationDetailRequest.fromJson(Map<String, dynamic> map) {
    return PreparationDetailRequest(
      preparationId:
          map['preparation_id'] != null ? map['preparation_id'] as int : null,
      assetId: map['asset_id'] != null ? map['asset_id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      rackId: map['rack_id'] != null ? map['rack_id'] as int : null,
      boxId: map['box_id'] != null ? map['box_id'] as int : null,
      preparedBy: map['prepared_by'] != null ? map['prepared_by'] as int : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      preparationId,
      assetId,
      quantity,
      rackId,
      boxId,
      preparedBy,
    ];
  }
}
