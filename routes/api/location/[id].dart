// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/locations/location_export.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  if (context.httpMethodGet) {
    return await LocationResponse.findLocationById(context, id);
  } else if (context.httpMethodPatch) {
    return await LocationResponse.updateLocation(context, id);
  }
  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
