// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/locations/domain/entities/location.dart';
import 'package:dartz/dartz.dart';

abstract class LocationRepository {
  // Location
  Future<Either<Failure, List<Location>>> findAllLocation();
  Future<Either<Failure, Location>> createLocation(Location params);
  Future<Either<Failure, Location>> updateLocation(Location params);
  Future<Either<Failure, Location>> findByIdLocation(int params);

  // Location Detail
  Future<Either<Failure, List<LocationDetail>>> findAllLocationDetail();
  Future<Either<Failure, LocationDetail>> createLocationDetail(
    LocationDetail params,
  );
  Future<Either<Failure, LocationDetail>> updateLocationDetail(
    LocationDetail params,
  );
  Future<Either<Failure, LocationDetail>> findByIdLocationDetail(
    int params,
  );

  // Location Team
  Future<Either<Failure, List<LocationTeam>>> findAllLocationTeam();
  Future<Either<Failure, LocationTeam>> createLocationTeam(LocationTeam params);
  Future<Either<Failure, LocationTeam>> updateLocationTeam(LocationTeam params);
  Future<Either<Failure, LocationTeam>> findByIdLocationTeam(
    int params,
  );

  // Location Rack
  Future<Either<Failure, List<LocationRack>>> findAllLocationRack();
  Future<Either<Failure, LocationRack>> createLocationRack(LocationRack params);
  Future<Either<Failure, LocationRack>> updateLocationRack(LocationRack params);
  Future<Either<Failure, LocationRack>> findByIdLocationRack(int params);

  // Location Box
  Future<Either<Failure, List<LocationBox>>> findAllLocationBox();
  Future<Either<Failure, LocationBox>> createLocationBox(LocationBox params);
  Future<Either<Failure, LocationBox>> updateLocationBox(LocationBox params);
  Future<Either<Failure, LocationBox>> findByIdLocationBox(int params);
}
