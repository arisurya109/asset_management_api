// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/categories/data/model/category_model.dart';
import 'package:asset_management_api/features/categories/data/source/category_local_data_source.dart';
import 'package:asset_management_api/features/categories/domain/entities/category.dart';
import 'package:asset_management_api/features/categories/domain/repositories/category_repositories.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._source);

  final CategoryLocalDataSource _source;

  @override
  Future<Either<Failure, Category>> createCategory(Category params) async {
    try {
      final response =
          await _source.createCategory(CategoryModel.fromEntity(params));
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> findAllCategory() async {
    try {
      final response = await _source.findAllCategory();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Category>> updateCategory(Category params) async {
    try {
      final response =
          await _source.updateCategory(CategoryModel.fromEntity(params));
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Category>> findCategoryById(int id) async {
    try {
      final response = await _source.findCategoryById(id);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
