// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/asset_categories/asset_category_export.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  if (context.httpMethodGet) {
    return await AssetCategoryResponse.findByIdAssetCategory(context, id);
  } else if (context.httpMethodPut) {
    return await AssetCategoryResponse.updateAssetCategory(context, id);
  }
  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
