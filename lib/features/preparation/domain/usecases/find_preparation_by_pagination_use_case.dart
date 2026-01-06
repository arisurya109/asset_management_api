// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindPreparationByPaginationUseCase {
  FindPreparationByPaginationUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, List<Preparation>>> call({
    required int page,
    required int limit,
    String? query,
  }) async {
    return _repository.findPreparationByPagination(
      page: page,
      limit: limit,
      query: query,
    );
  }
}
