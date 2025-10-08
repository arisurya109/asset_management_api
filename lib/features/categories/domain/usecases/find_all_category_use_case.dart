// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/categories/domain/entities/category.dart';
import 'package:asset_management_api/features/categories/domain/repositories/category_repositories.dart';
import 'package:dartz/dartz.dart';

class FindAllCategoryUseCase {
  FindAllCategoryUseCase(this._repository);

  final CategoryRepository _repository;

  Future<Either<Failure, List<Category>>> call() async {
    return _repository.findAllCategory();
  }
}
