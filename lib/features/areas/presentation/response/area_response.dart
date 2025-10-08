// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/areas/domain/usecases/find_all_area_use_case.dart';
import 'package:asset_management_api/features/areas/domain/usecases/find_area_by_id_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AreaResponse {
  AreaResponse._();

  static Future<Response> findAllArea(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllAreaUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all area',
          body: r.map((e) => e.toResponse()),
        ),
      );
    }
  }

  static Future<Response> findAreaById(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final params = await context.parseUri(id);

      final usecase = context.read<FindAreaByIdUseCase>();

      final response = await usecase(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get area',
          body: r.toResponse(),
        ),
      );
    }
  }
}
