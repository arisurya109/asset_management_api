// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/data/model/asset_model.dart';
import 'package:asset_management_api/features/assets/data/source/asset_local_data_source.dart';
import 'package:asset_management_api/features/assets/domain/entities/asset.dart';
import 'package:asset_management_api/features/assets/domain/repositories/asset_repositories.dart';
import 'package:dartz/dartz.dart';

class AssetRepositoryImpl implements AssetRepository {
  AssetRepositoryImpl(this._source);

  final AssetLocalDataSource _source;

  @override
  Future<Either<Failure, Asset>> createAsset(Asset params) async {
    try {
      final response = await _source.createAsset(AssetModel.fromEntity(params));
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Asset>>> findAllAsset() async {
    try {
      final response = await _source.findAllAsset();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Asset>> updateAsset(Asset params) async {
    try {
      final response = await _source.updateAsset(AssetModel.fromEntity(params));
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Asset>> findAssetById(int id) async {
    try {
      final response = await _source.findAssetById(id);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
