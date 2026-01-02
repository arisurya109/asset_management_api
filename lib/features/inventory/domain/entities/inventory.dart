// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management_api/features/inventory/domain/entities/inventory_box.dart';
import 'package:equatable/equatable.dart';

class Inventory extends Equatable {
  Inventory({
    this.totalBox,
    this.boxs,
  });

  int? totalBox;
  List<InventoryBox>? boxs;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'total_box': totalBox,
      'box': boxs,
    };
  }

  @override
  List<Object?> get props => [totalBox, boxs];
}
