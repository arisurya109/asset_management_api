// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/locations/location_export.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler locationInjector(Handler handler) {
  return handler
      .use(provider<FindAllLocationUseCase>((_) => findAllLocationUseCase))
      .use(provider<FindLocationByIdUseCase>((_) => findLocationByIdUseCase))
      .use(provider<CreateLocationUseCase>((_) => createLocationUseCase))
      .use(provider<UpdateLocationUseCase>((_) => updateLocationUseCase));
}
