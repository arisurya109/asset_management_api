// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/hash_password.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/users/domain/usecases/change_password_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class ChangePasswordResponse {
  const ChangePasswordResponse._();

  static Future<Response> changePassword(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final changePasswordUseCase = context.read<ChangePasswordUseCase>();

      final params = await context.requestJSON();

      final response = await changePasswordUseCase(
        params['username'] as String,
        hashPassword(params['password'] as String),
        hashPassword(params['new_password'] as String),
      );

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: r,
        ),
      );
    }
  }
}
