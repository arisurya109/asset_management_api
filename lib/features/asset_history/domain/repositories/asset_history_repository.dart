// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_history/domain/entities/asset_history.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class AssetHistoryRepository {
  Future<Either<Failure, List<AssetHistory>>> findAllHistoryAssetById(
    int params,
  );
}
