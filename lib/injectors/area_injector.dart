// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/areas/area_export.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler areaInjector(Handler handler) {
  return handler
      .use(provider<FindAllAreaUseCase>((_) => findAllAreaUseCase))
      .use(provider<FindAreaByIdUseCase>((_) => findAreaByIdUseCase));
}
