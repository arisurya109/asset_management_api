// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/asset_migration/data/model/asset_migration_model.dart';
import 'package:asset_management_api/features/asset_migration/data/source/asset_migration_local_data_source.dart';
import 'package:asset_management_api/features/asset_migration/domain/entities/asset_migration.dart';
import 'package:asset_management_api/features/asset_migration/domain/repositories/asset_migration_repository.dart';
import 'package:dartz/dartz.dart';

class AssetMigrationRepositoryImpl implements AssetMigrationRepository {
  AssetMigrationRepositoryImpl(this._source);

  final AssetMigrationLocalDataSource _source;

  @override
  Future<Either<Failure, AssetMigration>> migrationAsset(
    AssetMigration params,
  ) async {
    try {
      final response = await _source.migrationAsset(
        AssetMigrationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
