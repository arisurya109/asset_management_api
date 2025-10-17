// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler assetsInjector(Handler handler) {
  return handler
      .use(provider<FindAllAssetsUseCase>((_) => findAllAssetsUseCase))
      .use(provider<CreateAssetsUseCase>((_) => createAssetsUseCase));
}
