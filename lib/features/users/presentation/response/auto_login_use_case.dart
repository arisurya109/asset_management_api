// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/users/domain/usecases/auto_login_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AutoLoginResponse {
  const AutoLoginResponse._();

  static Future<Response> autoLogin(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: 'Please login again');
    } else {
      final usecase = context.read<AutoLoginUseCase>();

      final id = await jwt.getIdUser(context);

      final loggedUser = await usecase(id);

      return loggedUser.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) async {
          return ResponseHelper.json(
            code: HttpStatus.ok,
            status: 'Ok',
            body: r.toResponseLogin(),
          );
        },
      );
    }
  }
}
