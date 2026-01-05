// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_response_pagination.dart';
import 'package:dartz/dartz.dart';

class FindAssetByPaginationUseCase {
  FindAssetByPaginationUseCase(this._repository);

  final AssetsRepository _repository;

  Future<Either<Failure, AssetsResponsePagination>> call({
    required int page,
    required int limit,
    String? query,
  }) async {
    return _repository.findAssetByPagination(
      page: page,
      limit: limit,
      query: query,
    );
  }
}
