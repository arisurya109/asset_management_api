// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
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
        PreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Preparation>>> findAllPreparation() async {
    try {
      final response = await _source.findAllPreparation();
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> findPreparationById({
    required int params,
  }) async {
    try {
      final response = await _source.findPreparationById(params);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updateStatusApprovedPreparation({
    required int id,
    required int userId,
  }) async {
    try {
      final response = await _source.updateStatusApprovedPreparation(
        id: id,
        userId: userId,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updateStatusAssignedPreparation({
    required int id,
    required int userId,
  }) async {
    try {
      final response = await _source.updateStatusAssignedPreparation(
        id: id,
        userId: userId,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updateStatusCancelledPreparation({
    required int id,
    required int userId,
  }) async {
    try {
      final response = await _source.updateStatusCancelledPreparation(
        id: id,
        userId: userId,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updateStatusCompletedPreparation({
    required int id,
    required int userId,
    required List<int> fileBytes,
    required String originalName,
  }) async {
    try {
      final response = await _source.updateStatusCompletedPreparation(
        id: id,
        userId: userId,
        fileBytes: fileBytes,
        originalName: originalName,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updateStatusPickingPreparation({
    required int id,
    required int userId,
  }) async {
    try {
      final response = await _source.updateStatusPickingPreparation(
        id: id,
        userId: userId,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updateStatusReadyPreparation({
    required int id,
    required int userId,
    required int locationId,
    required int totalBox,
  }) async {
    try {
      final response = await _source.updateStatusReadyPreparation(
        id: id,
        userId: userId,
        locationId: locationId,
        totalBox: totalBox,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      print(e.message);
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      print(e.message);
      return Left(UpdateFailure(e.message));
    }
  }
}
