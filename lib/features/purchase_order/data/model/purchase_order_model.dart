// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management_api/features/purchase_order/data/model/purchase_order_detail_model.dart';
import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PurchaseOrderModel extends Equatable {
  int? id;
  String? purchaseOrderNumber;
  int? vendorId;
  int? createdById;
  String? remarks;
  String? status;
  String? createdBy;
  String? vendor;
  List<PurchaseOrderDetailModel>? items;

  PurchaseOrderModel({
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

  factory PurchaseOrderModel.fromMap(Map<String, dynamic> map) {
    return PurchaseOrderModel(
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
          ? List<PurchaseOrderDetailModel>.from(
              (map['items'] as List).map<PurchaseOrderDetailModel?>(
                (x) => PurchaseOrderDetailModel.fromDatabase(
                  x as Map<String, dynamic>,
                ),
              ),
            )
          : null,
    );
  }

  factory PurchaseOrderModel.fromEntity(PurchaseOrder params) {
    return PurchaseOrderModel(
      id: params.id,
      createdBy: params.createdBy,
      createdById: params.createdById,
      items: params.items?.map(PurchaseOrderDetailModel.fromEntity).toList(),
      purchaseOrderNumber: params.purchaseOrderNumber,
      remarks: params.remarks,
      status: params.status,
      vendor: params.vendor,
      vendorId: params.vendorId,
    );
  }

  PurchaseOrder toEntity() {
    return PurchaseOrder(
      id: id,
      vendor: vendor,
      vendorId: vendorId,
      createdBy: createdBy,
      createdById: createdById,
      purchaseOrderNumber: purchaseOrderNumber,
      remarks: remarks,
      status: status,
      items: items?.map((e) => e.toEntity()).toList(),
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
