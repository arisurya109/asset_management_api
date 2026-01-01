// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_destination_external_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_destination_internal_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_code_or_destination_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_preparation_use_case.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler preparationInjector(Handler handler) {
  return handler
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
        provider<FindPreparationByCodeOrDestinationUseCase>(
          (_) => findPreparationByCodeOrDestinationUseCase,
        ),
      )
      .use(
        provider<UpdateStatusPreparationUseCase>(
          (_) => updateStatusPreparationUseCase,
        ),
      )
      .use(
        provider<FindDestinationExternalUseCase>(
          (_) => findDestinationExternalUseCase,
        ),
      )
      .use(
        provider<FindDestinationInternalUseCase>(
          (_) => findDestinationInternalUseCase,
        ),
      );
}
