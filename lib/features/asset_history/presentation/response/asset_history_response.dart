// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_history/domain/usecases/find_all_history_asset_by_id_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AssetHistoryResponse {
  AssetHistoryResponse._();

  static Future<Response> findAllHistoryAssetById(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final params = await context.parseUri(id);

      final usecase = context.read<FindAllHistoryAssetByIdUseCase>();

      final failureOrHistory = await usecase(params);

      return failureOrHistory.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get history asset',
          body: r.map((e) => e.toMap()).toList(),
        ),
      );
    }
  }
}
