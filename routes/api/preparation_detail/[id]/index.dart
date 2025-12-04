// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/preparation_detail/presentation/response/preparation_detail_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  if (context.httpMethodGet) {
    return await PreparationDetailResponse.findPreparationDetailById(
      context,
      id,
    );
  } else if (context.httpMethodPatch) {
    final status = context.request.uri.queryParameters['status'];

    if (status == null || status.isEmpty) {
      return ResponseHelper.badRequest(
        description: 'Status is required.',
      );
    }

    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return await PreparationDetailResponse.updateStatusCompleted(
          context,
          id,
        );
      case 'PROGRESS':
        return await PreparationDetailResponse.updateStatusProgress(
          context,
          id,
        );
      default:
        return ResponseHelper.badRequest(
          description: 'Invalid status value.',
        );
    }
  } else if (context.httpMethodPut) {
    return PreparationDetailResponse.updatePreparationDetail(context, id);
  }

  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
