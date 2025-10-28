// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_models/data/model/asset_model_models.dart';
import 'package:asset_management_api/features/asset_models/data/source/asset_model_local_data_source.dart';
import 'package:asset_management_api/features/asset_models/domain/entities/asset_model.dart';
import 'package:asset_management_api/features/asset_models/domain/repositories/asset_model_repository.dart';
import 'package:dartz/dartz.dart';

class AssetModelRepositoryImpl implements AssetModelRepository {
  AssetModelRepositoryImpl(this._source);

  final AssetModelLocalDataSource _source;

  @override
  Future<Either<Failure, AssetModel>> createAssetModel(
    AssetModel params,
  ) async {
    try {
      final response = await _source.createAssetModel(
        AssetModelModels.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetModel>>> findAllAssetModel() async {
    try {
      final response = await _source.findAllAssetModel();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetModel>> findByIdAssetModel(int params) async {
    try {
      final response = await _source.findByIdAssetModel(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetModel>> updateAssetModel(
    AssetModel params,
  ) async {
    try {
      final response = await _source.updateAssetModel(
        AssetModelModels.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
