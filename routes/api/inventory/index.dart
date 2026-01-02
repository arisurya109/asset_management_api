// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/inventory/presentation/response/inventory_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final queryParams = context.request.uri.queryParameters;

  final location = queryParams['location'];

  if (context.httpMethodGet && location.isFilled()) {
    return await InventoryResponse.findInventory(context, location!);
  }

  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
