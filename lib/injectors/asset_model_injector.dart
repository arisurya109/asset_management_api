// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_models/asset_model_export.dart';
import 'package:asset_management_api/features/asset_models/domain/usecases/find_asset_model_by_query_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler assetModelInjector(Handler handler) {
  return handler
      .use(
        provider<FindAllAssetModelUseCase>(
          (_) => findAllAssetModelUseCase,
        ),
      )
      .use(
        provider<CreateAssetModelUseCase>(
          (_) => createAssetModelUseCase,
        ),
      )
      .use(
        provider<FindByIdAssetModelUseCase>(
          (_) => findByIdAssetModelUseCase,
        ),
      )
      .use(
        provider<UpdateAssetModelUseCase>(
          (_) => updateAssetModelUseCase,
        ),
      )
      .use(
        provider<FindAssetModelByQueryUseCase>(
          (_) => findAssetModelByQueryUseCase,
        ),
      );
}
