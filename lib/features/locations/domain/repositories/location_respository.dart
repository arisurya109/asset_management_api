// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/locations/domain/entities/location.dart';
import 'package:dartz/dartz.dart';

abstract class LocationRespository {
  Future<Either<Failure, List<Location>>> findAllLocation();
  Future<Either<Failure, Location>> findLocationById(int params);
  Future<Either<Failure, Location>> createLocation(Location params);
  Future<Either<Failure, Location>> updateLocation(Location params);
}
