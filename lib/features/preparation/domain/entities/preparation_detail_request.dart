// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetailRequest extends Equatable {
  int? id;
  int? preparationId;
  int? assetModelId;
  String? purchaseOrder;
  int? quantity;

  PreparationDetailRequest({
    this.id,
    this.preparationId,
    this.assetModelId,
    this.purchaseOrder,
    this.quantity,
  });

  factory PreparationDetailRequest.jsonCreate(Map<String, dynamic> map) {
    return PreparationDetailRequest(
      preparationId:
          map['preparation_id'] != null ? map['preparation_id'] as int : null,
      assetModelId: map['model_id'] != null ? map['model_id'] as int : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  factory PreparationDetailRequest.jsonRemove(Map<String, dynamic> map) {
    return PreparationDetailRequest(
      id: map['id'] != null ? map['id'] as int : null,
      preparationId:
          map['preparation_id'] != null ? map['preparation_id'] as int : null,
    );
  }

  String? validateCreateRequest() {
    if (preparationId == null) {
      return 'Preparation Id Cannot empty';
    } else if (assetModelId == null) {
      return 'Asset Cannot Empty';
    } else if (quantity == null) {
      return 'Quantity Cannot Empty';
    } else {
      return null;
    }
  }

  String? validateDeleteRequest() {
    if (id == null) {
      return 'Id Cannot empty';
    } else if (preparationId == null) {
      return 'Preparation Id Cannot empty';
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props {
    return [
      id,
      preparationId,
      assetModelId,
      purchaseOrder,
      quantity,
    ];
  }
}
