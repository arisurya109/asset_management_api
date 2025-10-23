// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PurchaseOrder extends Equatable {
  int? id;
  String? purchaseOrderNumber;
  int? vendorId;
  int? createdById;
  String? remarks;
  String? status;
  String? createdBy;
  String? vendor;
  List<PurchaseOrderDetail>? items;

  PurchaseOrder({
    this.id,
    this.purchaseOrderNumber,
    this.vendorId,
    this.createdById,
    this.remarks,
    this.status,
    this.createdBy,
    this.vendor,
    this.items,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'purchase_order_number': purchaseOrderNumber,
      'remarks': remarks,
      'created_by': createdBy,
      'status': status,
      'vendor': vendor,
      'items': items?.map((e) => e.toJson()).toList(),
    };
  }

  factory PurchaseOrder.fromJson(Map<String, dynamic> map) {
    return PurchaseOrder(
      id: map['id'] != null ? map['id'] as int : null,
      purchaseOrderNumber: map['purchase_order_number'] != null
          ? map['purchase_order_number'] as String
          : null,
      vendorId: map['vendor_id'] != null ? map['vendor_id'] as int : null,
      createdById:
          map['created_by_id'] != null ? map['created_by_id'] as int : null,
      createdBy: map['created_by'] != null ? map['created_by'] as String : null,
      remarks: map['remarks'] != null ? map['remarks'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      vendor: map['vendor'] != null ? map['vendor'] as String : null,
      items: map['items'] != null
          ? List<PurchaseOrderDetail>.from(
              (map['items'] as List).map<PurchaseOrderDetail?>(
                (x) => PurchaseOrderDetail.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      purchaseOrderNumber,
      vendorId,
      createdById,
      createdBy,
      remarks,
      status,
      vendor,
      items,
    ];
  }
}
