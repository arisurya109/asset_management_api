// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_categories/domain/entities/asset_category.dart';
import 'package:asset_management_api/features/asset_categories/domain/repositories/asset_category_repository.dart';
import 'package:dartz/dartz.dart';

class FindByIdAssetCategoryUseCase {
  FindByIdAssetCategoryUseCase(this._repository);

  final AssetCategoryRepository _repository;

  Future<Either<Failure, AssetCategory>> call(int params) async {
    return _repository.findByIdAssetCategory(params);
  }
}
