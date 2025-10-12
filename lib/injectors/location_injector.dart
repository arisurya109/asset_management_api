// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/locations/location_export.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler locationInjector(Handler handler) {
  return handler
      .use(
        provider<CreateLocationBoxUseCase>(
          (_) => createLocationBoxUseCase,
        ),
      )
      .use(
        provider<CreateLocationRackUseCase>(
          (_) => createLocationRackUseCase,
        ),
      )
      .use(
        provider<CreateLocationTeamUseCase>(
          (_) => createLocationTeamUseCase,
        ),
      )
      .use(
        provider<CreateLocationDetailUseCase>(
          (_) => createLocationDetailUseCase,
        ),
      )
      .use(
        provider<CreateLocationUseCase>(
          (_) => createLocationUseCase,
        ),
      )
      .use(
        provider<FindAllLocationBoxUseCase>(
          (_) => findAllLocationBoxUseCase,
        ),
      )
      .use(
        provider<FindAllLocationRackUseCase>(
          (_) => findAllLocationRackUseCase,
        ),
      )
      .use(
        provider<FindAllLocationTeamUseCase>(
          (_) => findAllLocationTeamUseCase,
        ),
      )
      .use(
        provider<FindAllLocationDetailUseCase>(
          (_) => findAllLocationDetailUseCase,
        ),
      )
      .use(
        provider<FindAllLocationUseCase>(
          (_) => findAllLocationUseCase,
        ),
      );
}
