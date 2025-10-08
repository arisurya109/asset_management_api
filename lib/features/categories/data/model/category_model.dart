// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/categories/domain/entities/category.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CategoryModel extends Equatable {
  int? id;
  String? categoryCode;
  String? categoryName;
  String? categoryInit;

  CategoryModel({
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
      'category_code': categoryCode,
      'category_name': categoryName,
      'category_init': categoryInit,
    };
  }

  Category toEntity() {
    return Category(
      id: id,
      categoryCode: categoryCode,
      categoryInit: categoryInit,
      categoryName: categoryName,
    );
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      categoryCode:
          map['category_code'] != null ? map['category_code'] as String : null,
      categoryName:
          map['category_name'] != null ? map['category_name'] as String : null,
      categoryInit:
          map['category_init'] != null ? map['category_init'] as String : null,
    );
  }
  factory CategoryModel.fromEntity(Category params) {
    return CategoryModel(
      id: params.id,
      categoryCode: params.categoryCode,
      categoryName: params.categoryName,
      categoryInit: params.categoryInit,
    );
  }
}
