// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/brands/brand_export.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler brandInjector(Handler handler) {
  return handler
      .use(provider<CreateBrandUseCase>((_) => createBrandUseCase))
      .use(provider<FindAllBrandUseCase>((_) => findAllBrandUseCase))
      .use(provider<UpdateBrandUseCase>((_) => updateBrandUseCase))
      .use(
        provider<FindBrandByIdAssetUseCase>((_) => findBrandByIdAssetUseCase),
      )
      .use(provider<FindBrandByIdUseCase>((_) => findBrandByIdUseCase));
}
