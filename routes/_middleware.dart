import 'package:asset_management_api/injectors/asset_migration_injector.dart';
import 'package:asset_management_api/injectors/asset_model_injector.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:asset_management_api/injectors/location_injector.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler
      .use(logger)
      .use(jwtInjector)
      .use(userInjector)
      .use(moduleInjector)
      .use(assetTypeInjector)
      .use(assetCategoryInjector)
      .use(assetBrandInjector)
      .use(assetModelInjector)
      .use(locationInjector)
      .use(assetMigrationInjector);
}
