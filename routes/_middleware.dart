import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:asset_management_api/injectors/logger_injector.dart';
import 'package:asset_management_api/injectors/module_permission_injector.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler
      .use(logger)
      .use(jwtInjector)
      .use(userInjector)
      .use(categoryInjector)
      .use(brandInjector)
      .use(assetTypeInjector)
      .use(moduleInjector)
      .use(areaInjector);
}
