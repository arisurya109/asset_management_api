// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_type/domain/entities/asset_type.dart';
import 'package:asset_management_api/features/asset_type/domain/repositories/asset_type_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetTypeUseCase {
  FindAllAssetTypeUseCase(this._repository);

  final AssetTypeRepository _repository;

  Future<Either<Failure, List<AssetType>>> call() async {
    return _repository.findAllAssetType();
  }
}
