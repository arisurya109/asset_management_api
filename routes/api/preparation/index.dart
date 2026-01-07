// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/preparation/presentation/response/preparation_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final queryParams = context.request.uri.queryParameters;
  final page = queryParams['page'];
  final limit = queryParams['page'];
  final params = queryParams['query'];
  if (context.httpMethodPost) {
    return await PreparationResponse.createPreparation(context);
  } else if (context.httpMethodGet) {
    if (page.isFilled() && limit.isFilled()) {
      return await PreparationResponse.findPreparationByPagination(
        context,
        params,
        limit!,
        page!,
      );
    }
    if (params == 'TYPES') {
      return await PreparationResponse.getPreparationTypes(
        context,
      );
    }
  }

  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
