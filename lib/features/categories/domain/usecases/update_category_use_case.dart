// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/categories/domain/entities/category.dart';
import 'package:asset_management_api/features/categories/domain/repositories/category_repositories.dart';
import 'package:dartz/dartz.dart';

class UpdateCategoryUseCase {
  UpdateCategoryUseCase(this._repository);

  final CategoryRepository _repository;

  Future<Either<Failure, Category>> call(Category params) async {
    return _repository.updateCategory(params);
  }
}
