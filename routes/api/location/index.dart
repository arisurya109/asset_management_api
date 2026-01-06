// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final queryParams = context.request.uri.queryParameters;

  final searchQuery = queryParams['query'];
  final searchCategory = queryParams['category'];
  final searchType = queryParams['type'];
  final limit = queryParams['limit'];
  final page = queryParams['page'];

  if (context.httpMethodPost) {
    return await LocationResponse.createLocation(context);
  }

  if (context.httpMethodGet) {
    if (searchType != null) {
      return await LocationResponse.findAllLocationType(context);
    }

    if (searchCategory != null) {
      final validCategories = ['STORAGE', 'NON STORAGE'];

      if (!validCategories.contains(searchCategory)) {
        return ResponseHelper.badRequest(
          description: 'Category not valid. Use STORAGE or NON STORAGE',
        );
      }

      final isStorage = searchCategory == 'STORAGE' ? '1' : '0';
      return await LocationResponse.findLocationByStorage(
        context,
        isStorage,
      );
    }

    if (limit.isFilled() && page.isFilled()) {
      return await LocationResponse.findLocationByPagination(
        context,
        searchQuery,
        limit!,
        page!,
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
