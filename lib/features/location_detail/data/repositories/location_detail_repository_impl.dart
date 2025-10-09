// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location_detail/data/model/location_detail_model.dart';
import 'package:asset_management_api/features/location_detail/data/source/location_detail_local_data_source.dart';
import 'package:asset_management_api/features/location_detail/domain/entities/location_detail.dart';
import 'package:asset_management_api/features/location_detail/domain/repositories/location_detail%20_repository.dart';
import 'package:dartz/dartz.dart';

class LocationDetailRepositoryImpl implements LocationDetailRepository {
  LocationDetailRepositoryImpl(this._source);

  final LocationDetailLocalDataSource _source;

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
  Future<Either<Failure, List<LocationDetail>>> findAllLocationDetail() async {
    try {
      final response = await _source.findAllLocationDetail();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LocationDetail>> updateLocationDetail(
    LocationDetail params,
  ) async {
    try {
      final response = await _source.updateLocationDetail(
        LocationDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
