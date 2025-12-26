// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.httpMethodPost) {
    return await LocationResponse.createLocation(context);
  } else if (context.httpMethodGet) {
    final params = context.request.uri.queryParameters;

    final isStorageParam = params['is_storage'];

    final queryParam = params['query']?.trim();
    final hasQuery = queryParam.isFilled();

    if (isStorageParam == '1') {
      return await LocationResponse.findAllLocationStorage(context);
    } else if (isStorageParam == '0') {
      return await LocationResponse.findAllLocationNonStorage(context);
    } else if (hasQuery) {
      return await LocationResponse.findLocationByQuery(context, queryParam!);
    }

    return await LocationResponse.findAllLocation(context);
  }
  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
