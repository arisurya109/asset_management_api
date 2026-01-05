// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_models/asset_model_export.dart';
import 'package:dartz/dartz.dart';

class FindAssetModelByQueryUseCase {
  FindAssetModelByQueryUseCase(this._repository);

  final AssetModelRepository _repository;

  Future<Either<Failure, List<AssetModel>>> call(String params) async {
    return _repository.findAssetModelByQuery(params);
  }
}
