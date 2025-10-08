// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/areas/data/source/area_local_data_source.dart';
import 'package:asset_management_api/features/areas/domain/entities/area.dart';
import 'package:asset_management_api/features/areas/domain/repositories/area_repository.dart';
import 'package:dartz/dartz.dart';

class AreaRepositoryImpl implements AreaRepository {
  AreaRepositoryImpl(this._source);

  final AreaLocalDataSource _source;

  @override
  Future<Either<Failure, List<Area>>> findAllArea() async {
    try {
      final response = await _source.findAllArea();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Area>> findAreaById(int params) async {
    try {
      final response = await _source.findAreaById(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
