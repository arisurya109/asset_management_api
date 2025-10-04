// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/hash_password.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/users/domain/usecases/login_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class LoginResponse {
  const LoginResponse._();

  static Future<Response> login(RequestContext context) async {
    final jwt = context.read<JwtService>();
    final params = await context.requestJSON();
    final loginUseCase = context.read<LoginUseCase>();

    final loggedUser = await loginUseCase(
      params['username'] as String,
      hashPassword(params['password'] as String),
    );

    return loggedUser.fold(
      (l) => ResponseHelper.badRequest(description: l.message!),
      (r) async {
        final token = await jwt.generateToken({'id': r.id});
        return ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Ok',
          body: r.toResponseLogin(),
          token: token,
        );
      },
    );
  }
}
