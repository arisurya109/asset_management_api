// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/data/model/assets_request_model.dart';
import 'package:asset_management_api/features/assets/data/source/assets_local_data_source.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_detail.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_request.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_response.dart';
import 'package:asset_management_api/features/assets/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class AssetsRepositoryImpl implements AssetsRepository {
  AssetsRepositoryImpl(this._source);

  final AssetsLocalDataSource _source;

  @override
  Future<Either<Failure, List<AssetsResponse>>> findAllAssets() async {
    try {
      final response = await _source.findAllAssets();
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetsResponse>> createAssets(
    AssetsRequest params,
  ) async {
    try {
      final response = await _source.createAssets(
        AssetsRequestModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetsDetail>>> findAssetDetailById(
    int params,
  ) async {
    try {
      final response = await _source.findAssetDetailById(params);
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetsResponse>> createAssetTransfer({
    required int movementById,
    required int assetId,
    required String movementType,
    required int fromLocationId,
    required int toLocationId,
    int quantity = 1,
    String? notes,
  }) async {
    try {
      final response = await _source.createAssetTransfer(
        assetId: assetId,
        movementById: movementById,
        movementType: movementType,
        fromLocationId: fromLocationId,
        toLocationId: toLocationId,
        quantity: quantity,
        notes: notes,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetsResponse>> findAssetByAssetCodeAndLocation({
    required String assetCode,
    required String location,
  }) async {
    try {
      final response = await _source.findAssetByAssetCodeAndLocation(
        assetCode: assetCode,
        location: location,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetsResponse>>> findAssetByQuery({
    required String params,
  }) async {
    try {
      final response = await _source.findAssetByQuery(
        params: params,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
