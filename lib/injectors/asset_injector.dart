// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/assets/asset_export.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler assetInjector(Handler handler) {
  return handler
      .use(provider<CreateAssetUseCase>((_) => createAssetUseCase))
      .use(provider<FindAllAssetUseCase>((_) => findAllAssetUseCase))
      .use(provider<FindAssetByIdUseCase>((_) => findAssetByIdUseCase))
      .use(provider<UpdateAssetUseCase>((_) => updateAssetUseCase));
}
