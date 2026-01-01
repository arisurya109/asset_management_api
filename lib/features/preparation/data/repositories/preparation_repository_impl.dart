// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/domain/entities/location.dart';
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
  Future<Either<Failure, List<Preparation>>>
      findPreparationByCodeOrDestination({
    required String params,
  }) async {
    try {
      final response =
          await _source.findPreparationByCodeOrDestination(params: params);
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updateStatusPreparation({
    required int id,
    required String status,
    required int userId,
    int? totalBox,
    int? locationId,
    String? remarks,
  }) async {
    try {
      final response = await _source.updateStatusPreparation(
        id: id,
        status: status,
        userId: userId,
        locationId: locationId,
        remarks: remarks,
        totalBox: totalBox,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(UpdateFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> findDestinationExternal() async {
    try {
      final response = await _source.findDestinationExternal();
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(UpdateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> findDestinationInternal() async {
    try {
      final response = await _source.findDestinationInternal();
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(UpdateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
