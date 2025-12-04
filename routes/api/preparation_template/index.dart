// ignore_for_file: unnecessary_await_in_return

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/preparation_template/presentation/response/preparation_template_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.httpMethodPost) {
    return await PreparationTemplateResponse.createPreparationTemplate(context);
  } else if (context.httpMethodGet) {
    return await PreparationTemplateResponse.findAllPreparationTemplate(
      context,
    );
  }
  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
