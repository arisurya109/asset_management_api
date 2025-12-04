// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation_item/domain/usecases/create_preparation_item_use_case.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/delete_preparation_item_use_case.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/find_all_preparation_item_by_preparation_detail_id_use_case.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/find_all_preparation_item_by_preparation_id_use_case.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler preparationItemInjector(Handler handler) {
  return handler
      .use(
        provider<CreatePreparationItemUseCase>(
          (_) => createPreparationItemUseCase,
        ),
      )
      .use(
        provider<DeletePreparationItemUseCase>(
          (_) => deletePreparationItemUseCase,
        ),
      )
      .use(
        provider<FindAllPreparationItemByPreparationIdUseCase>(
          (_) => findAllPreparationItemByPreparationIdUseCase,
        ),
      )
      .use(
        provider<FindAllPreparationItemByPreparationDetailIdUseCase>(
          (_) => findAllPreparationItemByPreparationDetailIdUseCase,
        ),
      );
}
