// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/asset_migration/asset_migration_export.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.httpMethodPost) {
    return await AssetMigrationResponse.createNewAsset(context);
  } else if (context.httpMethodGet) {
    return await AssetMigrationResponse.findAllAsset(context);
  } else if (context.httpMethodPatch) {
    return await AssetMigrationResponse.migrationAsset(context);
  }
  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
