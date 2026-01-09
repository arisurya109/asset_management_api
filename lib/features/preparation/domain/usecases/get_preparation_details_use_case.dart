// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail_response.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class GetPreparationDetailsUseCase {
  GetPreparationDetailsUseCase(this._repository);

  final PreparationDetailRepository _repository;

  Future<Either<Failure, PreparationDetailResponse>> call({
    required int preparationId,
  }) async {
    return _repository.getPreparationDetails(
      preparationId: preparationId,
    );
  }
}
