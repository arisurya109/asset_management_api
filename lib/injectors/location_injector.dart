// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/location/domain/usecases/delete_location_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_all_location_type_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_by_pagination_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_by_query_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_non_storage_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_storage_use_case.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler locationInjector(Handler handler) {
  return handler
      .use(
        provider<CreateLocationUseCase>(
          (_) => createLocationUseCase,
        ),
      )
      .use(
        provider<FindAllLocationUseCase>(
          (_) => findAllocationUseCase,
        ),
      )
      .use(
        provider<UpdateLocationUseCase>(
          (_) => updateocationUseCase,
        ),
      )
      .use(
        provider<FindByIdLocationUseCase>(
          (_) => findByIdocationUseCase,
        ),
      )
      .use(
        provider<FindLocationByQueryUseCase>(
          (_) => findLocationByQueryUseCase,
        ),
      )
      .use(
        provider<FindLocationStorageUseCase>(
          (_) => findLocationStorageUseCase,
        ),
      )
      .use(
        provider<FindLocationNonStorageUseCase>(
          (_) => findLocationNonStorageUseCase,
        ),
      )
      .use(
        provider<FindAllLocationTypeUseCase>(
          (_) => findAllLocationTypeUseCase,
        ),
      )
      .use(
        provider<DeleteLocationUseCase>(
          (_) => deleteLocationUseCase,
        ),
      )
      .use(
        provider<FindLocationByPaginationUseCase>(
          (_) => findLocationByPaginationUseCase,
        ),
      );
}
