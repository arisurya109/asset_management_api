// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_brand/domain/entities/asset_brand.dart';
import 'package:asset_management_api/features/asset_brand/domain/repositories/asset_brand_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetBrandUseCase {
  FindAllAssetBrandUseCase(this._repository);

  final AssetBrandRepository _repository;

  Future<Either<Failure, List<AssetBrand>>> call() async {
    return _repository.findAllAssetBrand();
  }
}
