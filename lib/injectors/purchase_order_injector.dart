// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/purchase_order/purchase_order_export.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler purchaseOrderInjector(Handler handler) {
  return handler
      .use(
        provider<CreatePurchaseOrderUseCase>(
          (_) => createPurchaseOrderUseCase,
        ),
      )
      .use(
        provider<FindAllPurchaseOrderUseCase>(
          (_) => findAllPurchaseOrderUseCase,
        ),
      )
      .use(
        provider<FindPurchaseOrderDetailItemUseCase>(
          (_) => findPurchaseOrderDetailItemUseCase,
        ),
      )
      .use(
        provider<UpdatePurchaseOrderUseCase>(
          (_) => updatePurchaseOrderUseCase,
        ),
      );
}
