import 'package:asset_management_api/injectors/injector_export.dart';
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
      .use(assetMigrationInjector)
      .use(assetTransferInjector)
      .use(assetsInjector)
      .use(assetHistoryInjector);
}
