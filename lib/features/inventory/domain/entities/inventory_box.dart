// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:equatable/equatable.dart';

class InventoryBox extends Equatable {
  InventoryBox({
    this.id,
    this.name,
    this.quantityAsset,
    this.boxType,
  });

  int? id;
  String? name;
  int? quantityAsset;
  String? boxType;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantity': quantityAsset,
      'type': boxType,
    };
  }

  @override
  List<Object?> get props => [id, name, quantityAsset, boxType];
}
