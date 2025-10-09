// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/location_detail/domain/entities/location_detail.dart';
import 'package:asset_management_api/features/location_detail/domain/usecases/create_location_detail_use_case.dart';
import 'package:asset_management_api/features/location_detail/domain/usecases/find_all_location_detail_use_case.dart';
import 'package:asset_management_api/features/location_detail/domain/usecases/update_location_detal_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class LocationDetailResponse {
  LocationDetailResponse._();

  static Future<Response> createLocationDetail(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateLocationDetailUseCase>();
      final params = await context.requestJSON();

      final response = await usecase(LocationDetail.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create new location detail',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAllLocationDetail(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllLocationDetailUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all location detail',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> updateLocationDetail(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateLocationDetalUseCase>();
      final params = await context.requestJSON();
      final paramsId = await context.parseUri(id);

      params
        ..remove('id')
        ..addEntries({'id': paramsId}.entries);

      final response = await usecase(LocationDetail.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update location detail',
          body: r.toResponse(),
        ),
      );
    }
  }
}
