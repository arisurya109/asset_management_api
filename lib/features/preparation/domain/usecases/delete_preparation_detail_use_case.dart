// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail_request.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePreparationDetailUseCase {
  DeletePreparationDetailUseCase(this._repository);

  final PreparationDetailRepository _repository;

  Future<Either<Failure, String>> call({
    required PreparationDetailRequest params,
    required int userId,
  }) async {
    return _repository.addPreparationDetail(
      params: params,
      userId: userId,
    );
  }
}
