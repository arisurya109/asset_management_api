// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/areas/domain/entities/area.dart';
import 'package:dartz/dartz.dart';

abstract class AreaRepository {
  Future<Either<Failure, List<Area>>> findAllArea();
  Future<Either<Failure, Area>> findAreaById(int params);
}
