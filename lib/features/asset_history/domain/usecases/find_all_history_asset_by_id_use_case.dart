// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_history/domain/entities/asset_history.dart';
import 'package:asset_management_api/features/asset_history/domain/repositories/asset_history_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllHistoryAssetByIdUseCase {
  FindAllHistoryAssetByIdUseCase(this._repository);

  final AssetHistoryRepository _repository;

  Future<Either<Failure, List<AssetHistory>>> call(int params) async {
    return _repository.findAllHistoryAssetById(params);
  }
}
