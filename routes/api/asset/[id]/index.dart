// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/movement/presentation/response/movement_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  final queryParams = context.request.uri.queryParameters;

  final movement = queryParams['movement'];

  if (context.httpMethodGet) {
    return await AssetsResponseUser.findAssetDetailById(context, id);
  } else if (movement.isFilled() && context.httpMethodPost) {
    if (movement == 'TRANSFER') {
      return await MovementResponse.movementTransfer(context, id);
    } else if (movement == 'PREPARATION') {
      return await MovementResponse.movementPreparation(context, id);
    } else if (movement == 'RETURN') {
      return await MovementResponse.movementReturn(context, id);
    }
  }

  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
