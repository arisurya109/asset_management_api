import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/features/reprint/presentation/response/reprint_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.httpMethodGet) {
    final params = context.request.uri.queryParameters;

    final query = params['query'];
    final type = params['type'];

    if (type == 'ASSET') {
      return ReprintResponse.asset(context, query!);
    } else if (type == 'LOCATION') {
      return ReprintResponse.location(context, query!);
    } else {
      return ResponseHelper.methodNotAllowed(
        description: ErrorMsg.methodAllowed,
      );
    }
  } else {
    return ResponseHelper.methodNotAllowed(description: ErrorMsg.methodAllowed);
  }
}
