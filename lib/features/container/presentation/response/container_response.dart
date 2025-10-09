// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/container/domain/entities/container.dart';
import 'package:asset_management_api/features/container/domain/usecases/create_container_use_case.dart';
import 'package:asset_management_api/features/container/domain/usecases/find_all_container_use_case.dart';
import 'package:asset_management_api/features/container/domain/usecases/update_container_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class ContainerResponse {
  ContainerResponse._();

  static Future<Response> createContainer(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateContainerUseCase>();
      final params = await context.requestJSON();

      final response = await usecase(Container.fromMap(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create container',
          body: r.toMap(),
        ),
      );
    }
  }

  static Future<Response> findAllContainer(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllContainerUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all container',
          body: r.map((e) => e.toMap()).toList(),
        ),
      );
    }
  }

  static Future<Response> updateContainer(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateContainerUseCase>();
      final params = await context.requestJSON();
      final paramsId = await context.parseUri(id);

      params
        ..remove('id')
        ..addEntries({'id': paramsId}.entries);

      final response = await usecase(Container.fromMap(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update container',
          body: r.toMap(),
        ),
      );
    }
  }
}
