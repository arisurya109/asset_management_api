// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_transfer/data/model/asset_transfer_model.dart';
import 'package:asset_management_api/features/asset_transfer/data/source/asset_transfer_local_data_source.dart';
import 'package:asset_management_api/features/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:asset_management_api/features/asset_transfer/domain/repositories/asset_transfer_repository.dart';
import 'package:dartz/dartz.dart';

class AssetTransferRepositoryImpl implements AssetTransferRepository {
  AssetTransferRepositoryImpl(this._source);

  final AssetTransferLocalDataSource _source;

  @override
  Future<Either<Failure, AssetTransfer>> createAssetTransfer(
    AssetTransfer params,
  ) async {
    try {
      final response = await _source.createAssetTransfer(
        AssetTransferModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
