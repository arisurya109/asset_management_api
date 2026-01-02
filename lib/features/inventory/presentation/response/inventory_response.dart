// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/inventory/domain/usecases/find_inventory_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class InventoryResponse {
  InventoryResponse._();

  static Future<Response> findInventory(
    RequestContext context,
    String params,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindInventoryUseCase>();

      final response = await usecase(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully inventory',
          body: r.toJson(),
        ),
      );
    }
  }
}
