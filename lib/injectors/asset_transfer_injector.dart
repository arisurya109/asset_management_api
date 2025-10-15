// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/asset_transfer/asset_transfer_export.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler assetTransferInjector(Handler handler) {
  return handler.use(
    provider<CreateAssetTransferUseCase>(
      (_) => createAssetTransferUseCase,
    ),
  );
}
