// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_categories/asset_category_export.dart';
import 'package:dartz/dartz.dart';

class FindAssetCategoryByQueryUseCase {
  FindAssetCategoryByQueryUseCase(this._repository);

  final AssetCategoryRepository _repository;

  Future<Either<Failure, List<AssetCategory>>> call(String params) async {
    return _repository.findAssetCategoryByQuery(params);
  }
}
