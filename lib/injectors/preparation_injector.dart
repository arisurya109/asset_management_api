// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_template_item_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/delete_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_template_item_by_template_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_template_use_case.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler preparationInjector(Handler handler) {
  return handler
      .use(
        provider<CreatePreparationTemplateUseCase>(
          (_) => createPreparationTemplateUseCase,
        ),
      )
      .use(
        provider<CreatePreparationTemplateItemUseCase>(
          (_) => createPreparationTemplateItemUseCase,
        ),
      )
      .use(
        provider<DeletePreparationTemplateUseCase>(
          (_) => deletePreparationTemplateUseCase,
        ),
      )
      .use(
        provider<FindAllPreparationTemplateUseCase>(
          (_) => findAllPreparationTemplateUseCase,
        ),
      )
      .use(
        provider<FindAllPreparationTemplateItemByTemplateIdUseCase>(
          (_) => findAllPreparationTemplateItemByTemplateIdUseCase,
        ),
      );
}
