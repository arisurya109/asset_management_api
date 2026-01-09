// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation/domain/usecases/add_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_pagination_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/get_preparation_details_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/get_preparation_types_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_preparation_status_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler preparationInjector(Handler handler) {
  return handler
      .use(
        provider<CreatePreparationUseCase>(
          (_) => createPreparationUseCase,
        ),
      )
      .use(
        provider<UpdatePreparationStatusUseCase>(
          (_) => updatePreparationStatusUseCase,
        ),
      )
      .use(
        provider<FindPreparationByPaginationUseCase>(
          (_) => findPreparationByPaginationUseCase,
        ),
      )
      .use(
        provider<GetPreparationTypesUseCase>(
          (_) => getPreparationTypesUseCase,
        ),
      )
      .use(
        provider<GetPreparationDetailsUseCase>(
          (_) => getPreparationDetailsUseCase,
        ),
      )
      .use(
        provider<AddPreparationDetailUseCase>(
          (_) => addPreparationDetailUseCase,
        ),
      );
}
