// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/categories/domain/entities/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> findAllCategory();
  Future<Either<Failure, Category>> createCategory(Category params);
  Future<Either<Failure, Category>> updateCategory(Category params);
  Future<Either<Failure, Category>> findCategoryById(int id);
}
