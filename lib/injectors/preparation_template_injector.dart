// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation_template/domain/usecases/create_preparation_template_item_use_case.dart';
import 'package:asset_management_api/features/preparation_template/domain/usecases/create_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation_template/domain/usecases/find_all_preparation_template_item_by_template_id_use_case.dart';
import 'package:asset_management_api/features/preparation_template/domain/usecases/find_all_preparation_template_use_case.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler preparationTemplateInjector(Handler handler) {
  return handler
      .use(
        provider<CreatePreparationTemplateItemUseCase>(
          (_) => createPreparationTemplateItemUseCase,
        ),
      )
      .use(
        provider<CreatePreparationTemplateUseCase>(
          (_) => createPreparationTemplateUseCase,
        ),
      )
      .use(
        provider<FindAllPreparationTemplateItemByTemplateIdUseCase>(
          (_) => findAllPreparationTemplateItemByTemplateIdUseCase,
        ),
      )
      .use(
        provider<FindAllPreparationTemplateUseCase>(
          (_) => findAllPreparationTemplateUseCase,
        ),
      );
}
