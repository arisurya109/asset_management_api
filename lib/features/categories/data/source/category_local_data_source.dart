// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/categories/data/model/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> findAllCategory();
  Future<CategoryModel> createCategory(CategoryModel params);
  Future<CategoryModel> updateCategory(CategoryModel params);
  Future<CategoryModel> findCategoryById(int id);
}
