// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_models/domain/entities/asset_model.dart';
import 'package:asset_management_api/features/asset_models/domain/repositories/asset_model_repository.dart';
import 'package:dartz/dartz.dart';

class FindByIdAssetModelUseCase {
  FindByIdAssetModelUseCase(this._repository);

  final AssetModelRepository _repository;

  Future<Either<Failure, AssetModel>> call(int params) async {
    return _repository.findByIdAssetModel(params);
  }
}
