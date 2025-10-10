// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_type/asset_type_export.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler assetTypeInjector(Handler handler) {
  return handler
      .use(provider<FindAllAssetTypeUseCase>((_) => findAllAssetTypeUseCase))
      .use(provider<UpdateAssetTypeUseCase>((_) => updateAssetTypeUseCase))
      .use(provider<CreateAssetTypeUseCase>((_) => createAssetTypeUseCase))
      .use(provider<FindByIdAssetTypeUseCase>((_) => findByIdAssetTypeUseCase));
}
