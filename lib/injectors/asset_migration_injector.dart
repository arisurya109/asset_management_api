// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_migration/asset_migration_export.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler assetMigrationInjector(Handler handler) {
  return handler.use(
    provider<MigrationAssetUseCase>(
      (_) => migrationAssetUseCase,
    ),
  );
}
