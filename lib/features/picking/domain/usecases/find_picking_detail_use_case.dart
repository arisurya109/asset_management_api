// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_detail_response.dart';
import 'package:asset_management_api/features/picking/domain/repositories/picking_repository.dart';
import 'package:dartz/dartz.dart';

class FindPickingDetailUseCase {
  FindPickingDetailUseCase(this._repository);

  final PickingRepository _repository;

  Future<Either<Failure, PickingDetailResponse>> call({
    required int params,
    required int userId,
  }) async {
    return _repository.findPickingDetail(
      id: params,
      userId: userId,
    );
  }
}
