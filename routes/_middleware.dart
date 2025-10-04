import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:asset_management_api/injectors/logger_injector.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler
      .use(logger)
      .use(jwtInjector)
      .use(userInjector)
      .use(assetInjector)
      .use(brandInjector)
      .use(assetTypeInjector);
}
