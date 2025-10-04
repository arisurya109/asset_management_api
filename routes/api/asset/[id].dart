// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/assets/presentation/response/asset_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  if (context.httpMethodPut) {
    return await AssetResponse.updateAsset(context, id);
  } else if (context.httpMethodGet) {
    return await AssetResponse.findAssetById(context, id);
  }
  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
