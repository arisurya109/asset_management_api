// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/container_detail/domain/entities/container_detail.dart';
import 'package:asset_management_api/features/container_detail/domain/usecases/create_container_detail_use_case.dart';
import 'package:asset_management_api/features/container_detail/domain/usecases/find_all_container_detail_use_case.dart';
import 'package:asset_management_api/features/container_detail/domain/usecases/update_container_detail_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class ContainerDetailResponse {
  ContainerDetailResponse._();

  static Future<Response> createContainerDetail(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateContainerDetailUseCase>();
      final params = await context.requestJSON();

      final response = await usecase(ContainerDetail.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create container detail',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> updateContainerDetail(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateContainerDetailUseCase>();
      final params = await context.requestJSON();
      final paramsId = await context.parseUri(id);

      params
        ..remove('id')
        ..addEntries({'id': paramsId}.entries);

      final response = await usecase(ContainerDetail.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update container detail',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAllContainerDetail(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllContainerDetailUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all container detail',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }
}
