// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_categories/asset_category_export.dart';
import 'package:asset_management_api/features/asset_categories/domain/usecases/find_asset_category_by_query_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler assetCategoryInjector(Handler handler) {
  return handler
      .use(
        provider<FindAllAssetCategoryUseCase>(
          (_) => findAllAssetCategoryUseCase,
        ),
      )
      .use(
        provider<CreateAssetCategoryUseCase>(
          (_) => createAssetCategoryUseCase,
        ),
      )
      .use(
        provider<FindByIdAssetCategoryUseCase>(
          (_) => findByIdAssetCategoryUseCase,
        ),
      )
      .use(
        provider<UpdateAssetCategoryUseCase>(
          (_) => updateAssetCategoryUseCase,
        ),
      )
      .use(
        provider<FindAssetCategoryByQueryUseCase>(
          (_) => findAssetCategoryByQueryUseCase,
        ),
      );
}
