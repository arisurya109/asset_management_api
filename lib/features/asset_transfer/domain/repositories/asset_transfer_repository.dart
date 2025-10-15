// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:dartz/dartz.dart';

abstract class AssetTransferRepository {
  Future<Either<Failure, AssetTransfer>> createAssetTransfer(
    AssetTransfer params,
  );
}
