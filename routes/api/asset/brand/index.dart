// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/asset_brand/asset_brand_export.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final queryParams = context.request.uri.queryParameters;

  final query = queryParams['query'];

  if (context.httpMethodPost) {
    return await AssetBrandResponse.createAssetBrand(context);
  } else if (context.httpMethodGet) {
    if (query.isFilled()) {
      return await AssetBrandResponse.findAssetBrandByQuery(context, query!);
    }
    return await AssetBrandResponse.findAllAssetBrand(context);
  }
  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
