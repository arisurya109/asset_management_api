// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation/domain/usecases/completed_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_item_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_template_item_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/delete_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/dispatch_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_detail_by_preparation_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_item_by_preparation_detail_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_item_by_preparation_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_template_item_by_template_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_document_preparation_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_detail_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_preparation_use_case.dart';
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
      )
      .use(
        provider<FindAllPreparationUseCase>(
          (_) => findAllPreparationUseCase,
        ),
      )
      .use(
        provider<FindPreparationByIdUseCase>(
          (_) => findPreparationByIdUseCase,
        ),
      )
      .use(
        provider<CreatePreparationUseCase>(
          (_) => createPreparationUseCase,
        ),
      )
      .use(
        provider<UpdatePreparationUseCase>(
          (_) => updatePreparationUseCase,
        ),
      )
      .use(
        provider<CreatePreparationDetailUseCase>(
          (_) => createPreparationDetailUseCase,
        ),
      )
      .use(
        provider<FindAllPreparationDetailByPreparationIdUseCase>(
          (_) => findAllPreparationDetailByPreparationIdUseCase,
        ),
      )
      .use(
        provider<FindPreparationDetailByIdUseCase>(
          (_) => findPreparationDetailByIdUseCase,
        ),
      )
      .use(
        provider<UpdatePreparationDetailUseCase>(
          (_) => updatePreparationDetailUseCase,
        ),
      )
      .use(
        provider<CreatePreparationItemUseCase>(
          (_) => createPreparationItemUseCase,
        ),
      )
      .use(
        provider<FindAllPreparationItemByPreparationDetailId>(
          (_) => findAllPreparationItemByPreparationDetailId,
        ),
      )
      .use(
        provider<FindAllPreparationItemByPreparationId>(
          (_) => findAllPreparationItemByPreparationId,
        ),
      )
      .use(
        provider<DispatchPreparationUseCase>(
          (_) => dispatchPreparationUseCase,
        ),
      )
      .use(
        provider<CompletedPreparationUseCase>(
          (_) => completedPreparationUseCase,
        ),
      )
      .use(
        provider<FindDocumentPreparationByIdUseCase>(
          (_) => findDocumentPreparationByIdUseCase,
        ),
      );
}
