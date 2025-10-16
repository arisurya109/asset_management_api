import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: must_be_immutable
class PurchaseOrder extends Equatable {
  int? id;
  String? purchaseOrderNumber;
  int? createdBy;
  int? supplierId;
  String? supplier;
  String? description;
  DateTime? createdAt;
  String? status;

  PurchaseOrder({
    this.id,
    this.purchaseOrderNumber,
    this.createdBy,
    this.supplierId,
    this.supplier,
    this.description,
    this.createdAt,
    this.status,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'purchase_order_number': purchaseOrderNumber,
      'supplier': {
        'id': supplierId,
        'name': supplier,
      },
      'status': status,
      'description': description,
    };
  }

  factory PurchaseOrder.fromRequest(Map<String, dynamic> map) {
    return PurchaseOrder(
      id: map['id'] != null ? map['id'] as int : null,
      purchaseOrderNumber: map['purchase_order_number'] != null
          ? map['purchase_order_number'] as String
          : null,
      createdBy: map['created_by'] != null ? map['created_by'] as int : null,
      supplierId: map['supplier_id'] != null ? map['supplier_id'] as int : null,
      supplier: map['supplier'] != null ? map['supplier'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      purchaseOrderNumber,
      createdBy,
      supplierId,
      supplier,
      description,
      createdAt,
      status,
    ];
  }
}
