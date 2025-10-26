import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:asset_management_api/injectors/purchase_order_injector.dart';
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
      .use(assetsInjector)
      .use(vendorInjector)
      .use(purchaseOrderInjector);
}
