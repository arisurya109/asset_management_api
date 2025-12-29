import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/extensions/string_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/preparation/presentation/response/preparation_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.httpMethodGet) {
    final queryParams = context.request.uri.queryParameters;

    final type = queryParams['type'];

    if (!type.isFilled()) {
      return ResponseHelper.badRequest(description: 'Type cannot be empty');
    } else if (type != 'I' && type != 'E') {
      return ResponseHelper.badRequest(description: 'Type not valide');
    } else {
      return PreparationResponse.findDestinationByType(context, type!);
    }
  }
  return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
}
