// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/preparation/presentation/response/preparation_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  if (context.httpMethodGet) {
    return await PreparationResponse.findPreparationById(context, id);
  }

  if (context.httpMethodPatch) {
    final status = context.request.uri.queryParameters['status'];

    if (status == null || status.isEmpty) {
      return ResponseHelper.badRequest(
        description: 'Status is required.',
      );
    }

    switch (status.toUpperCase()) {
      case 'ASSIGNED':
        return await PreparationResponse.updateStatusAssigned(context, id);
      case 'COMPLETED':
        return await PreparationResponse.updateStatusCompleted(context, id);
      case 'PICKING':
        return await PreparationResponse.updateStatusPicking(context, id);
      case 'APPROVED':
        return await PreparationResponse.updateStatusApproved(context, id);
      case 'READY':
        return await PreparationResponse.updateStatusReady(context, id);
      case 'CANCELLED':
        return await PreparationResponse.updateStatusCancelled(context, id);
      default:
        return ResponseHelper.badRequest(
          description: 'Invalid status value.',
        );
    }
  }

  return ResponseHelper.methodNotAllowed(
    description: ErrorMsg.methodAllowed,
  );
}
