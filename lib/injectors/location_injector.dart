// ignore_for_file: public_member_api_docs

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
      );
}
