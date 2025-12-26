// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/reprint/domain/usecases/reprint_asset_use_case.dart';
import 'package:asset_management_api/features/reprint/domain/usecases/reprint_location_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler reprintInjector(Handler handler) {
  return handler
      .use(
        provider<ReprintAssetUseCase>(
          (_) => reprintAssetUseCase,
        ),
      )
      .use(
        provider<ReprintLocationUseCase>(
          (_) => reprintLocationUseCase,
        ),
      );
}
