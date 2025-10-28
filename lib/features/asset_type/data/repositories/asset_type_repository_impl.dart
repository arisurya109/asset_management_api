// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_type/data/model/type_model.dart';
import 'package:asset_management_api/features/asset_type/data/source/asset_type_local_data_source.dart';
import 'package:asset_management_api/features/asset_type/domain/entities/asset_type.dart';
import 'package:asset_management_api/features/asset_type/domain/repositories/asset_type_repository.dart';
import 'package:dartz/dartz.dart';

class AssetTypeRepositoryImpl implements AssetTypeRepository {
  AssetTypeRepositoryImpl(this._source);

  final AssetTypeLocalDataSource _source;

  @override
  Future<Either<Failure, AssetType>> createAssetType(AssetType params) async {
    try {
      final response = await _source.createType(
        AssetTypeModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetType>>> findAllAssetType() async {
    try {
      final response = await _source.findAllType();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetType>> findByIdAssetType(int params) async {
    try {
      final response = await _source.findByIdType(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetType>> updateAssetType(AssetType params) async {
    try {
      final response = await _source.updateType(
        AssetTypeModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
