// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_detail_local_data_source.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail_request.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail_response.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class PreparationDetailRepositoryImpl implements PreparationDetailRepository {
  PreparationDetailRepositoryImpl(this._source);

  final PreparationDetailLocalDataSource _source;

  @override
  Future<Either<Failure, String>> addPreparationDetail({
    required PreparationDetailRequest params,
    required int userId,
  }) async {
    try {
      final response = await _source.addPreparationDetail(
        params: params,
        userId: userId,
      );
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetailResponse>> getPreparationDetails({
    required int preparationId,
  }) async {
    try {
      final response = await _source.getPreparationDetails(
        preparationId: preparationId,
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
  Future<Either<Failure, String>> deletePreparationDetail({
    required PreparationDetailRequest params,
    required int userId,
  }) async {
    try {
      final response = await _source.deletePreparationDetail(
        params: params,
        userId: userId,
      );
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
