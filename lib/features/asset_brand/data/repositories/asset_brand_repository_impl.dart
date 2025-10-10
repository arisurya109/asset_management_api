// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_brand/data/model/asset_brand_model.dart';
import 'package:asset_management_api/features/asset_brand/data/source/asset_brand_local_data_source.dart';
import 'package:asset_management_api/features/asset_brand/domain/entities/asset_brand.dart';
import 'package:asset_management_api/features/asset_brand/domain/repositories/asset_brand_repository.dart';
import 'package:dartz/dartz.dart';

class AssetBrandRepositoryImpl implements AssetBrandRepository {
  AssetBrandRepositoryImpl(this._source);

  final AssetBrandLocalDataSource _source;

  @override
  Future<Either<Failure, AssetBrand>> createAssetBrand(
    AssetBrand params,
  ) async {
    try {
      final response = await _source.createAssetBrand(
        AssetBrandModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetBrand>>> findAllAssetBrand() async {
    try {
      final response = await _source.findAllAssetBrand();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetBrand>> findByIdAssetBrand(int params) async {
    try {
      final response = await _source.findByIdAssetBrand(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetBrand>> updateAssetBrand(
    AssetBrand params,
  ) async {
    try {
      final response = await _source.updateAssetBrand(
        AssetBrandModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
