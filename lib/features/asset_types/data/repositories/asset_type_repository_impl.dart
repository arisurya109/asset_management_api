// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_types/asset_type_export.dart';
import 'package:dartz/dartz.dart';

class AssetTypeRepositoryImpl implements AssetTypeRepository {
  AssetTypeRepositoryImpl(this._source);

  final AssetTypeLocalDataSource _source;

  @override
  Future<Either<Failure, AssetType>> createAssetType(AssetType params) async {
    try {
      final response = await _source.createAssetType(
        AssetTypeModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetType>>> findAllAssetType() async {
    try {
      final response = await _source.findAllAssetType();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetType>> findAssetTypeById(int params) async {
    try {
      final response = await _source.findAssetTypeById(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetType>>> findAssetTypeByIdBrand(
    int params,
  ) async {
    try {
      final response = await _source.findAssetTypeByIdBrand(params);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetType>> updateAssetType(AssetType params) async {
    try {
      final response = await _source.updateAssetType(
        AssetTypeModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
