// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/location/domain/entities/location_pagination.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:dartz/dartz.dart';

class FindLocationByPaginationUseCase {
  FindLocationByPaginationUseCase(this._repository);

  final LocationRepository _repository;

  Future<Either<Failure, LocationPagination>> call({
    required int page,
    required int limit,
    String? query,
  }) async {
    return _repository.findLocationByPagination(
      page: page,
      limit: limit,
      query: query,
    );
  }
}
