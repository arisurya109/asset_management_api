// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/picking/domain/usecases/find_all_picking_task_use_case.dart';
import 'package:asset_management_api/features/picking/domain/usecases/find_picking_detail_use_case.dart';
import 'package:asset_management_api/features/picking/domain/usecases/picked_asset_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler pickingInjector(Handler handler) {
  return handler
      .use(
        provider<FindAllPickingTaskUseCase>(
          (_) => findAllPickingTaskUseCase,
        ),
      )
      .use(
        provider<FindPickingDetailUseCase>(
          (_) => findPickingDetailUseCase,
        ),
      )
      .use(
        provider<PickedAssetUseCase>(
          (_) => pickedAssetUseCase,
        ),
      );
}
