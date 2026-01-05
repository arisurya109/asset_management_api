// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_by_pagination_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_by_query_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_detail_by_id_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/migration_asset_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/registration_asset_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler assetsInjector(Handler handler) {
  return handler
      .use(provider<FindAllAssetsUseCase>((_) => findAllAssetsUseCase))
      .use(
        provider<FindAssetDetailByIdUseCase>((_) => findAssetDetailByIdUseCase),
      )
      .use(
        provider<FindAssetByQueryUseCase>(
          (_) => findAssetByQueryUseCase,
        ),
      )
      .use(
        provider<RegistrationAssetUseCase>(
          (_) => registrationAssetUseCase,
        ),
      )
      .use(
        provider<MigrationAssetUseCase>(
          (_) => migrationAssetUseCase,
        ),
      )
      .use(
        provider<FindAssetByPaginationUseCase>(
          (_) => findAssetByPaginationUseCase,
        ),
      );
}
