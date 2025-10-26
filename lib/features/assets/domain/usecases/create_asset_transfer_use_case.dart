// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:dartz/dartz.dart';

class CreateAssetTransferUseCase {
  CreateAssetTransferUseCase(this._repository);

  final AssetsRepository _repository;

  Future<Either<Failure, AssetsResponse>> call({
    required int movementById,
    required int assetId,
    required String movementType,
    required int fromLocationId,
    required int toLocationId,
    int quantity = 1,
    String? notes,
  }) async {
    return _repository.createAssetTransfer(
      movementById: movementById,
      assetId: assetId,
      movementType: movementType,
      fromLocationId: fromLocationId,
      toLocationId: toLocationId,
      quantity: quantity,
      notes: notes,
    );
  }
}
