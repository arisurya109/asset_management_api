// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation_detail/domain/usecases/create_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/find_all_preparation_detail_by_preparation_id_use_case.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/find_preparation_detail_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/update_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/update_status_completed_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/update_status_progress_preparation_detail_use_case.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler preparationDetailInjector(Handler handler) {
  return handler
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
        provider<UpdateStatusCompletedPreparationDetailUseCase>(
          (_) => updateStatusCompletedPreparationDetailUseCase,
        ),
      )
      .use(
        provider<UpdateStatusProgressPreparationDetailUseCase>(
          (_) => updateStatusProgressPreparationDetailUseCase,
        ),
      );
}
