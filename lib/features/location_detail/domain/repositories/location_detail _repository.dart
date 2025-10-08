// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location_detail/domain/entities/location_detail.dart';
import 'package:dartz/dartz.dart';

abstract class LocationDetailRepository {
  Future<Either<Failure, LocationDetail>> createLocationDetail(
    LocationDetail params,
  );
  Future<Either<Failure, List<LocationDetail>>> findAllLocationDetail();
  Future<Either<Failure, LocationDetail>> updateLocationDetail(
    LocationDetail params,
  );
}
