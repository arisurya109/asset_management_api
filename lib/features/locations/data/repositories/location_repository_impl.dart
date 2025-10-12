// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/locations/data/model/location_model.dart';
import 'package:asset_management_api/features/locations/data/source/location_local_data_source.dart';
import 'package:asset_management_api/features/locations/domain/entities/location.dart';
import 'package:asset_management_api/features/locations/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl(this._source);

  final LocationLocalDataSource _source;

  @override
  Future<Either<Failure, Location>> createLocation(Location params) async {
    try {
      final response = await _source.createLocation(
        LocationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LocationBox>> createLocationBox(
    LocationBox params,
  ) async {
    try {
      final response = await _source.createLocationBox(
        LocationBoxModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LocationDetail>> createLocationDetail(
    LocationDetail params,
  ) async {
    try {
      final response = await _source.createLocationDetail(
        LocationDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LocationRack>> createLocationRack(
    LocationRack params,
  ) async {
    try {
      final response = await _source.createLocationRack(
        LocationRackModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LocationTeam>> createLocationTeam(
    LocationTeam params,
  ) async {
    try {
      final response = await _source.createLocationTeam(
        LocationTeamModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> findAllLocation() async {
    try {
      final response = await _source.findAllLocation();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<LocationBox>>> findAllLocationBox() async {
    try {
      final response = await _source.findAllLocationBox();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<LocationDetail>>> findAllLocationDetail() async {
    try {
      final response = await _source.findAllLocationDetail();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<LocationRack>>> findAllLocationRack() async {
    try {
      final response = await _source.findAllLocationRack();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<LocationTeam>>> findAllLocationTeam() async {
    try {
      final response = await _source.findAllLocationTeam();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Location>> findByIdLocation(int params) {
    // TODO: implement findByIdLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationBox>> findByIdLocationBox(int params) {
    // TODO: implement findByIdLocationBox
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationDetail>> findByIdLocationDetail(int params) {
    // TODO: implement findByIdLocationDetail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationRack>> findByIdLocationRack(int params) {
    // TODO: implement findByIdLocationRack
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationTeam>> findByIdLocationTeam(int params) {
    // TODO: implement findByIdLocationTeam
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Location>> updateLocation(Location params) {
    // TODO: implement updateLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationBox>> updateLocationBox(LocationBox params) {
    // TODO: implement updateLocationBox
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationDetail>> updateLocationDetail(
      LocationDetail params) {
    // TODO: implement updateLocationDetail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationRack>> updateLocationRack(
      LocationRack params) {
    // TODO: implement updateLocationRack
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationTeam>> updateLocationTeam(
      LocationTeam params) {
    // TODO: implement updateLocationTeam
    throw UnimplementedError();
  }
}
