// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management_api/features/inventory/data/model/inventory_box_model.dart';
import 'package:asset_management_api/features/inventory/domain/entities/inventory.dart';
import 'package:equatable/equatable.dart';

class InventoryModel extends Equatable {
  InventoryModel({
    this.totalBox,
    this.boxs,
  });

  int? totalBox;
  List<InventoryBoxModel>? boxs;

  Inventory toEntity() {
    return Inventory(
      totalBox: totalBox,
      boxs: boxs?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [totalBox, boxs];
}
