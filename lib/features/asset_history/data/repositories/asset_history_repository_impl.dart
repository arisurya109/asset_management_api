// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_history/data/source/asset_history_local_data_source.dart';
import 'package:asset_management_api/features/asset_history/domain/entities/asset_history.dart';
import 'package:asset_management_api/features/asset_history/domain/repositories/asset_history_repository.dart';
import 'package:dartz/dartz.dart';

class AssetHistoryRepositoryImpl implements AssetHistoryRepository {
  AssetHistoryRepositoryImpl(this._source);

  final AssetHistoryLocalDataSource _source;

  @override
  Future<Either<Failure, List<AssetHistory>>> findAllHistoryAssetById(
    int params,
  ) async {
    try {
      final response = await _source.findAllAssetHistoryById(params);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
