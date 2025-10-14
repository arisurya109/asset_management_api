// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_migration/domain/entities/asset_migration.dart';
import 'package:asset_management_api/features/asset_migration/domain/repositories/asset_migration_repository.dart';
import 'package:dartz/dartz.dart';

class MigrationAssetUseCase {
  MigrationAssetUseCase(this._repository);

  final AssetMigrationRepository _repository;

  Future<Either<Failure, AssetMigration>> call(AssetMigration params) async {
    return _repository.migrationAsset(params);
  }
}
