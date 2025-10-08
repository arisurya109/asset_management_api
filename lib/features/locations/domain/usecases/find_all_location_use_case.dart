// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/locations/domain/entities/location.dart';
import 'package:asset_management_api/features/locations/domain/repositories/location_respository.dart';
import 'package:dartz/dartz.dart';

class FindAllLocationUseCase {
  FindAllLocationUseCase(this._respository);

  final LocationRespository _respository;

  Future<Either<Failure, List<Location>>> call() async {
    return _respository.findAllLocation();
  }
}
