// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/location_detail/location_detail_export.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler locationDetailInjector(Handler handler) {
  return handler
      .use(
        provider<FindAllLocationDetailUseCase>(
          (_) => findAllLocationDetailUseCase,
        ),
      )
      .use(
        provider<CreateLocationDetailUseCase>(
          (_) => createLocationDetailUseCase,
        ),
      )
      .use(
        provider<UpdateLocationDetalUseCase>(
          (_) => updateLocationDetalUseCase,
        ),
      );
}
