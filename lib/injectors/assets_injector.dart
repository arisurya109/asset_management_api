// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/assets/domain/usecases/create_asset_transfer_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_by_asset_code_and_location_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_detail_by_id_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler assetsInjector(Handler handler) {
  return handler
      .use(provider<FindAllAssetsUseCase>((_) => findAllAssetsUseCase))
      .use(provider<CreateAssetsUseCase>((_) => createAssetsUseCase))
      .use(
        provider<CreateAssetTransferUseCase>((_) => createAssetTransferUseCase),
      )
      .use(
        provider<FindAssetDetailByIdUseCase>((_) => findAssetDetailByIdUseCase),
      )
      .use(
        provider<FindAssetByAssetCodeAndLocationUseCase>(
          (_) => findAssetByAssetCodeAndLocationUseCase,
        ),
      );
}
