// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/domain/entities/asset.dart';
import 'package:asset_management_api/features/assets/domain/repositories/asset_repositories.dart';
import 'package:dartz/dartz.dart';

class CreateAssetUseCase {
  CreateAssetUseCase(this._repository);

  final AssetRepository _repository;

  Future<Either<Failure, Asset>> call(Asset params) async {
    return _repository.createAsset(params);
  }
}
