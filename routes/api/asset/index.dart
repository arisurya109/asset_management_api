// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.httpMethodGet) {
    final queryParams = context.request.uri.queryParameters;

    final query = queryParams['query'];
    final limit = queryParams['limit'];
    final page = queryParams['page'];
    final id = queryParams['id'];

    if (limit.isFilled() && page.isFilled()) {
      return await AssetsResponseUser.findAssetByPagination(
        context,
        query,
        limit!,
        page!,
      );
    }

    if (query.isFilled()) {
      return await AssetsResponseUser.findAssetByQuery(context, query!);
    }

    if (id.isFilled()) {
      return await AssetsResponseUser.findAssetDetailById(context, id!);
    }

    return await AssetsResponseUser.findAllAssets(context);
  }
  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
