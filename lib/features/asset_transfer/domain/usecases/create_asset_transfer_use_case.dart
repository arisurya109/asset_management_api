// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:asset_management_api/features/asset_transfer/domain/repositories/asset_transfer_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssetTransferUseCase {
  CreateAssetTransferUseCase(this._repository);

  final AssetTransferRepository _repository;

  Future<Either<Failure, AssetTransfer>> call(AssetTransfer params) async {
    return _repository.createAssetTransfer(params);
  }
}
