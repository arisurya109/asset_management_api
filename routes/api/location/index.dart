// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final queryParams = context.request.uri.queryParameters;
  final query = context.request.uri.query;

  final isStorageParam = queryParams['is_storage'];
  final searchQuery = queryParams['query'];

  if (context.httpMethodPost) {
    return await LocationResponse.createLocation(context);
  }

  if (context.httpMethodGet) {
    if (query == 'type') {
      return await LocationResponse.findAllLocationType(context);
    }
    if (isStorageParam != null) {
      if (isStorageParam != '1' && isStorageParam != '0') {
        return ResponseHelper.badRequest(
          description:
              'Invalid value for "is_storage". Use "1" for true or "0" for false.',
        );
      }
      return await LocationResponse.findLocationByStorage(
        context,
        isStorageParam,
      );
    }

    if (searchQuery.isFilled()) {
      return await LocationResponse.findLocationByQuery(context, searchQuery!);
    }

    return await LocationResponse.findAllLocation(context);
  }

  return ResponseHelper.methodNotAllowed(
    description: ErrorMsg.methodAllowed,
  );
}
