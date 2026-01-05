// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_categories/data/model/asset_category_model.dart';
import 'package:asset_management_api/features/asset_categories/data/source/asset_category_local_data_source.dart';
import 'package:asset_management_api/features/asset_categories/domain/entities/asset_category.dart';
import 'package:asset_management_api/features/asset_categories/domain/repositories/asset_category_repository.dart';
import 'package:dartz/dartz.dart';

class AssetCategoryRepositoryImpl implements AssetCategoryRepository {
  AssetCategoryRepositoryImpl(this._source);

  final AssetCategoryLocalDataSource _source;

  @override
  Future<Either<Failure, AssetCategory>> createCategory(
    AssetCategory params,
  ) async {
    try {
      final response = await _source.createAssetCategory(
        AssetCategoryModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetCategory>>> findAllAssetCategory() async {
    try {
      final response = await _source.findAllAssetCategory();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetCategory>> findByIdAssetCategory(
    int params,
  ) async {
    try {
      final response = await _source.findByIdAssetCategory(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetCategory>> updateCategory(
    AssetCategory params,
  ) async {
    try {
      final response = await _source.updateAssetCategory(
        AssetCategoryModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetCategory>>> findAssetCategoryByQuery(
    String params,
  ) async {
    try {
      final response = await _source.findAssetCategoryByQuery(
        params,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
