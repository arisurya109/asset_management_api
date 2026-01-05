// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_brand/asset_brand_export.dart';
import 'package:asset_management_api/features/asset_brand/domain/usecases/find_asset_brand_by_query_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler assetBrandInjector(Handler handler) {
  return handler
      .use(
        provider<FindAllAssetBrandUseCase>(
          (_) => findAllAssetBrandUseCase,
        ),
      )
      .use(
        provider<CreateAssetBrandUseCase>(
          (_) => createAssetBrandUseCase,
        ),
      )
      .use(
        provider<FindByIdAssetBrandUseCase>(
          (_) => findByIdAssetBrandUseCase,
        ),
      )
      .use(
        provider<UpdateAssetBrandUseCase>(
          (_) => updateAssetBrandUseCase,
        ),
      )
      .use(
        provider<FindAssetBrandByQueryUseCase>(
          (_) => findAssetBrandByQueryUseCase,
        ),
      );
}
