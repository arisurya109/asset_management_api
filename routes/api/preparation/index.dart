// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/preparation/presentation/response/preparation_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final id = context.request.uri.queryParameters['id'];
  final query = context.request.uri.queryParameters['query'];

  if (context.httpMethodGet) {
    if (id.isFilled()) {
      return PreparationResponse.findPreparationById(context, id!);
    }
    if (query.isFilled()) {
      return PreparationResponse.findPreparationByCodeOrDestination(
        context,
        query!,
      );
    }
    return PreparationResponse.findAllPreparation(context);
  } else if (context.httpMethodPatch) {
    if (!id.isFilled()) {
      return ResponseHelper.badRequest(
        description: 'ID is required for update',
      );
    }
    return await PreparationResponse.updateStatusPreparation(context, id!);
  } else if (context.httpMethodPost) {
    return await PreparationResponse.createPreparation(context);
  }

  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
