// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_assigned_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_cancelled_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_completed_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_picking_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_preparation_approved_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_ready_preparation_use_case.dart';
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
        provider<UpdateStatusAssignedPreparationUseCase>(
          (_) => updateStatusAssignedPreparationUseCase,
        ),
      )
      .use(
        provider<UpdateStatusCancelledPreparationUseCase>(
          (_) => updateStatusCancelledPreparationUseCase,
        ),
      )
      .use(
        provider<UpdateStatusCompletedPreparationUseCase>(
          (_) => updateStatusCompletedPreparationUseCase,
        ),
      )
      .use(
        provider<UpdateStatusPickingPreparationUseCase>(
          (_) => updateStatusPickingPreparationUseCase,
        ),
      )
      .use(
        provider<UpdateStatusPreparationApprovedUseCase>(
          (_) => updateStatusPreparationApprovedUseCase,
        ),
      )
      .use(
        provider<UpdateStatusReadyPreparationUseCase>(
          (_) => updateStatusReadyPreparationUseCase,
        ),
      );
}
