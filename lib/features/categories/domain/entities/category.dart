// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  int? id;
  String? categoryCode;
  String? categoryName;
  String? categoryInit;

  Category({
    this.id,
    this.categoryCode,
    this.categoryName,
    this.categoryInit,
  });

  @override
  List<Object?> get props => [id, categoryCode, categoryName, categoryInit];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'asset_code': categoryCode,
      'asset_name': categoryName,
      'asset_init': categoryInit,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as int : null,
      categoryCode:
          map['category_code'] != null ? map['category_code'] as String : null,
      categoryName:
          map['category_name'] != null ? map['category_name'] as String : null,
      categoryInit:
          map['category_init'] != null ? map['category_init'] as String : null,
    );
  }
}
