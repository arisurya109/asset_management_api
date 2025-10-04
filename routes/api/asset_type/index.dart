// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/asset_types/presentation/response/asset_type_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.httpMethodPost) {
    return await AssetTypeResponse.createAssetType(context);
  } else if (context.httpMethodGet) {
    return await AssetTypeResponse.findAllAssetType(context);
  }
  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
