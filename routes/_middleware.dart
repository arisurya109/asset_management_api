import 'package:asset_management_api/injectors/cors_injector.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:asset_management_api/injectors/inventory_injector.dart';
import 'package:asset_management_api/injectors/movement_injector.dart';
import 'package:asset_management_api/injectors/picking_injector.dart';
import 'package:asset_management_api/injectors/preparation_injector.dart';
import 'package:asset_management_api/injectors/preparation_item_injector.dart';
import 'package:asset_management_api/injectors/preparation_template_injector.dart';
import 'package:asset_management_api/injectors/purchase_order_injector.dart';
import 'package:asset_management_api/injectors/reprint_injector.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler
      .use(logger)
      .use(corsInjector)
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
      .use(purchaseOrderInjector)
      .use(preparationItemInjector)
      .use(preparationTemplateInjector)
      .use(reprintInjector)
      .use(inventoryInjector)
      .use(movementInjector)
      .use(preparationInjector)
      .use(pickingInjector);
}
