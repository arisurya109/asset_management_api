// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/movement/presentation/response/movement_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  final queryParams = context.request.uri.queryParameters;

  final type = queryParams['type'];

  if (context.httpMethodPost && type.isFilled()) {
    if (type == 'TRANSFER') {
      return await MovementResponse.movementTransfer(context, id);
    } else if (type == 'PREPARATION') {
      return await MovementResponse.movementPreparation(context, id);
    } else if (type == 'RETURN') {
      return await MovementResponse.movementReturn(context, id);
    }
  }

  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
