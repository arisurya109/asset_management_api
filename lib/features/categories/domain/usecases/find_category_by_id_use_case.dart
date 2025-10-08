// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/categories/domain/entities/category.dart';
import 'package:asset_management_api/features/categories/domain/repositories/category_repositories.dart';
import 'package:dartz/dartz.dart';

class FindCategoryByIdUseCase {
  FindCategoryByIdUseCase(this._repository);

  final CategoryRepository _repository;

  Future<Either<Failure, Category>> call(int id) async {
    return _repository.findCategoryById(id);
  }
}
