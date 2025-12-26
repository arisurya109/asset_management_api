// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/domain/entities/location.dart';
import 'package:dartz/dartz.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<Location>>> findAllLocation();
  Future<Either<Failure, Location>> createLocation(Location params);
  Future<Either<Failure, Location>> updateLocation(Location params);
  Future<Either<Failure, Location>> findByIdLocation(int params);

  Future<Either<Failure, List<Location>>> findAllLocationStorage();
  Future<Either<Failure, List<Location>>> findLocationByQuery({
    required String params,
  });
  Future<Either<Failure, List<Location>>> findAllLocationNonStorage();
  Future<Either<Failure, void>> deleteLocationById(
    int params,
  );
}
