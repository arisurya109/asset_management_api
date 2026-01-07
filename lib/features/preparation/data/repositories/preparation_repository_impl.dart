// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_pagination.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class PreparationRepositoryImpl implements PreparationRepository {
  PreparationRepositoryImpl(this._source);

  final PreparationLocalDataSource _source;

  @override
  Future<Either<Failure, Preparation>> createPreparation({
    required Preparation params,
  }) async {
    try {
      final response = await _source.createPreparation(
        params: PreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationPagination>> findPreparationByPagination({
    required int page,
    required int limit,
    String? query,
  }) async {
    try {
      final response = await _source.findPreparationByPagination(
        limit: limit,
        page: page,
        query: query,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPreparationTypes() async {
    try {
      final response = await _source.getPreparationTypes();
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updatePreparationStatus({
    required int id,
    required String params,
    required int userId,
    int? totalBox,
    int? temporaryLocationId,
  }) async {
    try {
      final response = await _source.updatePreparationStatus(
        id: id,
        params: params,
        userId: userId,
        totalBox: totalBox,
        temporaryLocationId: temporaryLocationId,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
