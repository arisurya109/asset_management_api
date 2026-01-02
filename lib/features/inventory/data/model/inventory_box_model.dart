// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors_first

import 'package:asset_management_api/features/inventory/domain/entities/inventory_box.dart';
import 'package:equatable/equatable.dart';

class InventoryBoxModel extends Equatable {
  InventoryBoxModel({
    this.id,
    this.name,
    this.quantityAsset,
    this.boxType,
  });

  int? id;
  String? name;
  int? quantityAsset;
  String? boxType;

  factory InventoryBoxModel.fromDatabse(Map<String, dynamic> map) {
    return InventoryBoxModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      quantityAsset:
          map['quantity'] != null ? (map['quantity'] as double).toInt() : null,
      boxType: map['box_type'] != null ? map['box_type'] as String : null,
    );
  }

  InventoryBox toEntity() {
    return InventoryBox(
      id: id,
      name: name,
      boxType: boxType,
      quantityAsset: quantityAsset,
    );
  }

  @override
  List<Object?> get props => [id, name, quantityAsset, boxType];
}
