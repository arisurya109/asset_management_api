// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/hash_password.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/users/domain/usecases/delete_user_use_case.dart';
import 'package:asset_management_api/features/users/user_export.dart';

import 'package:dart_frog/dart_frog.dart';

class UserResponse {
  const UserResponse._();

  // Permission Module - 2
  static Future<Response> createUser(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(
        description: ErrorMsg.unAuthorized,
      );
    } else {
      final validatePermissionUser =
          await jwt.checkPermissionUser(context, 'user', 'add');

      if (!validatePermissionUser) {
        return ResponseHelper.unAuthorized(
          description: ErrorMsg.notAccessModul,
        );
      } else {
        final createUser = context.read<CreateUserUseCase>();

        final params = await context.requestJSON();

        final createdBy = await jwt.getUsername(context);

        params['password'] = hashPassword('Watsons_1nd0#');

        params['created_by'] = createdBy;

        params['modules'] = (params['modules'] as List)
            .map(
              (e) => {
                'id': e['id'],
                'name': e['name'],
                'module': e['module'],
              },
            )
            .toList();

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
  }

  // Permission Module - 1
  static Future<Response> findAllUser(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final validatePermissionUser =
          await jwt.checkPermissionUser(context, 'user', 'view');

      if (!validatePermissionUser) {
        return ResponseHelper.unAuthorized(
          description: ErrorMsg.notAccessModul,
        );
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
  }

  // Permission Module - 1
  static Future<Response> findByIdUser(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final validatePermissionUser =
          await jwt.checkPermissionUser(context, 'user', 'view');

      if (!validatePermissionUser) {
        return ResponseHelper.unAuthorized(
          description: ErrorMsg.notAccessModul,
        );
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
  }

  // Permission Module - 3
  static Future<Response> deleteUser(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final validatePermissionUser =
          await jwt.checkPermissionUser(context, 'user', 'delete');

      if (!validatePermissionUser) {
        return ResponseHelper.unAuthorized(
          description: ErrorMsg.notAccessModul,
        );
      } else {
        final deleteUser = context.read<DeleteUserUseCase>();
        final paramsId = await context.parseUri(id);

        final response = await deleteUser(
          paramsId,
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

  // Permission Module - 3
  static Future<Response> updateUser(RequestContext context, String id) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final validatePermissionUser =
          await jwt.checkPermissionUser(context, 'user', 'update');

      if (!validatePermissionUser) {
        return ResponseHelper.unAuthorized(
          description: ErrorMsg.notAccessModul,
        );
      } else {
        final updateUser = context.read<UpdateUserUseCase>();
        final paramsId = await context.parseUri(id);
        final paramsBody = await context.requestJSON();
        final password = hashPassword('Watsons_1nd0#');

        paramsBody.addAll({'id': paramsId, 'password': password});

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
}
