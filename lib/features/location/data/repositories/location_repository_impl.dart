// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/data/model/location_model.dart';
import 'package:asset_management_api/features/location/data/source/location_local_data_source.dart';
import 'package:asset_management_api/features/location/domain/entities/location.dart';
import 'package:asset_management_api/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl(this._source);

  final LocationLocalDataSource _source;

  @override
  Future<Either<Failure, Location>> createLocation(
    Location params,
    int userId,
  ) async {
    try {
      final response = await _source.createLocation(
        LocationModel.fromEntity(params),
        userId,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> findAllLocation() async {
    try {
      final response = await _source.findAllLocation();
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Location>> findByIdLocation(int params) async {
    try {
      final response = await _source.findByIdLocation(params);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Location>> updateLocation(Location params) async {
    try {
      final response = await _source.updateLocation(
        LocationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(UpdateFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> findLocationByQuery(
    String query,
  ) async {
    try {
      final response = await _source.findLocationByQuery(query);
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> findLocationNonStorage() async {
    try {
      final response = await _source.findLocationNonStorage();
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> findLocationStorage() async {
    try {
      final response = await _source.findLocationStorage();
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> findAllLocationType() async {
    try {
      final response = await _source.findAllLocationType();
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteLocation({
    required int id,
    required int userId,
  }) async {
    try {
      final response = await _source.deleteLocation(id: id, userId: userId);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DeleteFailure(e.message));
    } on DeleteException catch (e) {
      return Left(DeleteFailure(e.message));
    }
  }
}
