// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/inventory/domain/usecases/find_inventory_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler inventoryInjector(Handler handler) {
  return handler.use(
    provider<FindInventoryUseCase>(
      (_) => findInventoryUseCase,
    ),
  );
}
