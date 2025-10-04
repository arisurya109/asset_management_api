// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/hash_password.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/users/domain/entities/user.dart';
import 'package:asset_management_api/features/users/domain/usecases/create_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/find_all_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/find_by_id_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/update_status_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/update_user_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class UserResponse {
  const UserResponse._();

  static Future<Response> createUser(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(
        description: ErrorMsg.unAuthorized,
      );
    } else {
      final createUser = context.read<CreateUserUseCase>();
      final params = await context.requestJSON();

      params['password'] = hashPassword(params['password'] as String);

      final response = await createUser(User.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully created new user',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAllUser(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final findAllUser = context.read<FindAllUserUseCase>();
      final idRequest = await jwt.getIdUser(context);

      final response = await findAllUser(idRequest);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all user',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findByIdUser(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final findByIdUser = context.read<FindByIdUserUseCase>();
      final params = await context.parseUri(id);

      final response = await findByIdUser(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get user',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> updateStatusUser(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final updateStatusUser = context.read<UpdateStatusUserUseCase>();
      final paramsId = await context.parseUri(id);
      final paramsBody = await context.requestJSON();

      final response = await updateStatusUser(
        paramsId,
        paramsBody['is_active'] as int,
      );

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update status user',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> updateUser(RequestContext context, String id) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final updateUser = context.read<UpdateUserUseCase>();
      final paramsId = await context.parseUri(id);
      final paramsBody = await context.requestJSON();

      paramsBody.addEntries({'id': paramsId}.entries);

      final response = await updateUser(User.fromRequest(paramsBody));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update user',
          body: r.toResponse(),
        ),
      );
    }
  }
}
