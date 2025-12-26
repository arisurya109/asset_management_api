// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/features/assets/domain/entities/assets_response.dart';
import 'package:equatable/equatable.dart';

class AssetsResponseModel extends Equatable {
  int? id;
  String? serialNumber;
  String? assetCode;
  String? status;
  String? conditions;
  int? quantity;
  int? uom;
  String? model;
  String? category;
  String? brand;
  String? types;
  String? color;
  String? location;
  String? locationDetail;
  String? purchaseOrder;
  String? remarks;

  AssetsResponseModel({
    this.id,
    this.serialNumber,
    this.assetCode,
    this.status,
    this.conditions,
    this.quantity,
    this.uom,
    this.model,
    this.category,
    this.brand,
    this.types,
    this.color,
    this.location,
    this.locationDetail,
    this.purchaseOrder,
    this.remarks,
  });

  @override
  List<Object?> get props {
    return [
      id,
      serialNumber,
      assetCode,
      status,
      conditions,
      quantity,
      uom,
      model,
      category,
      brand,
      types,
      color,
      location,
      locationDetail,
      purchaseOrder,
      remarks,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'serial_number': serialNumber,
      'asset_code': assetCode,
      'status': status,
      'conditions': conditions,
      'quantity': quantity,
      'uom': uom,
      'model': model,
      'category': category,
      'brand': brand,
      'types': types,
      'color': color,
      'location': location,
      'location_detail': locationDetail,
      'purchase_order': purchaseOrder,
      'remarks': remarks,
    };
  }

  factory AssetsResponseModel.fromMap(Map<String, dynamic> map) {
    return AssetsResponseModel(
      id: map['id'] != null ? map['id'] as int : null,
      serialNumber:
          map['serial_number'] != null ? map['serial_number'] as String : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      conditions:
          map['conditions'] != null ? map['conditions'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      uom: map['uom'] != null ? map['uom'] as int : null,
      model: map['model'] != null ? map['model'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      types: map['types'] != null ? map['types'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      locationDetail: map['location_detail'] != null
          ? map['location_detail'] as String
          : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      remarks: map['remarks'] != null ? map['remarks'] as String : null,
    );
  }

  AssetsResponse toEntity() {
    return AssetsResponse(
      id: id,
      serialNumber: serialNumber,
      assetCode: assetCode,
      status: status,
      conditions: conditions,
      quantity: quantity,
      uom: uom,
      model: model,
      brand: brand,
      category: category,
      color: color,
      location: location,
      locationDetail: locationDetail,
      purchaseOrder: purchaseOrder,
      remarks: remarks,
      types: types,
    );
  }
}
