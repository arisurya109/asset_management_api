// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:dartz/dartz.dart';

class MigrationAssetUseCase {
  MigrationAssetUseCase(this._repository);

  final AssetsRepository _repository;

  Future<Either<Failure, AssetsResponse>> call(AssetsRequest params) async {
    return _repository.migrationAsset(params);
  }
}
