// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/container_detail/container_detail_export.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler containerDetailInjector(Handler handler) {
  return handler
      .use(
        provider<FindAllContainerDetailUseCase>(
          (_) => findAllContainerDetailUseCase,
        ),
      )
      .use(
        provider<CreateContainerDetailUseCase>(
          (_) => createContainerDetailUseCase,
        ),
      )
      .use(
        provider<UpdateContainerDetailUseCase>(
          (_) => updateContainerDetailUseCase,
        ),
      );
}
