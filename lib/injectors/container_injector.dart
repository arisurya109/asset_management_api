// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/container/container_export.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler containerInjector(Handler handler) {
  return handler
      .use(
        provider<FindAllContainerUseCase>(
          (_) => findAllContainerUseCase,
        ),
      )
      .use(
        provider<CreateContainerUseCase>(
          (_) => createContainerUseCase,
        ),
      )
      .use(
        provider<UpdateContainerUseCase>(
          (_) => updateContainerUseCase,
        ),
      );
}
