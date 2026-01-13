// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_detail.dart';
import 'package:asset_management_api/features/picking/domain/repositories/picking_repository.dart';
import 'package:dartz/dartz.dart';

class PickedAssetUseCase {
  PickedAssetUseCase(this._repository);

  final PickingRepository _repository;

  Future<Either<Failure, String>> call({
    required int userId,
    required PickingDetail params,
  }) async {
    return _repository.pickedAsset(
      userId: userId,
      params: params,
    );
  }
}
