// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_brand/asset_brand_export.dart';
import 'package:dartz/dartz.dart';

class FindAssetBrandByQueryUseCase {
  FindAssetBrandByQueryUseCase(this._repository);

  final AssetBrandRepository _repository;

  Future<Either<Failure, List<AssetBrand>>> call(String params) async {
    return _repository.findAssetBrandByQuery(params);
  }
}
