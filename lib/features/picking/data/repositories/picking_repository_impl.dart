// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/picking/data/model/picking_detail_model.dart';
import 'package:asset_management_api/features/picking/data/source/picking_local_data_source.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_detail.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_detail_response.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_header.dart';
import 'package:asset_management_api/features/picking/domain/repositories/picking_repository.dart';
import 'package:dartz/dartz.dart';

class PickingRepositoryImpl implements PickingRepository {
  PickingRepositoryImpl(this._source);

  final PickingLocalDataSource _source;

  @override
  Future<Either<Failure, List<PickingHeader>>> findAllPickingTask({
    required int userId,
  }) async {
    try {
      final response = await _source.findAllPickingTask(userId: userId);
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PickingDetailResponse>> findPickingDetail({
    required int id,
    required int userId,
  }) async {
    try {
      final response = await _source.findPickingDetail(
        userId: userId,
        id: id,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> pickedAsset({
    required int userId,
    required PickingDetail params,
  }) async {
    try {
      final response = await _source.pickedAsset(
        userId: userId,
        params: PickingDetailModel.fromEntity(params),
      );
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(UpdateFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
