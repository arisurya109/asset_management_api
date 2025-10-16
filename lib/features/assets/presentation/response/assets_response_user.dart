// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_all_assets_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AssetsResponseUser {
  AssetsResponseUser._();

  static Future<Response> findAllAssets(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllAssetsUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all asset',
          body: r.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }
}
