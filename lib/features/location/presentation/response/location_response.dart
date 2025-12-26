// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/location/domain/entities/location.dart';
import 'package:asset_management_api/features/location/domain/usecases/create_location_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/delete_location_by_id_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_all_location_non_storage_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_all_location_storage_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_all_location_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_by_id_location_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_by_query_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/update_location_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class LocationResponse {
  LocationResponse._();

  static Future<Response> createLocation(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.methodAllowed);
    } else {
      final usecase = context.read<CreateLocationUseCase>();
      final params = await context.requestJSON();

      final response = await usecase(Location.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully created new location',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAllLocation(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.methodAllowed);
    } else {
      final usecase = context.read<FindAllLocationUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all location',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findLocationByQuery(
    RequestContext context,
    String params,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.methodAllowed);
    } else {
      final usecase = context.read<FindLocationByQueryUseCase>();

      final response = await usecase(params: params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully find location',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findAllLocationNonStorage(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.methodAllowed);
    } else {
      final usecase = context.read<FindAllLocationNonStorageUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all location non storage',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findAllLocationStorage(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.methodAllowed);
    } else {
      final usecase = context.read<FindAllLocationStorageUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all location storage',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findByIdLocation(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.methodAllowed);
    } else {
      final usecase = context.read<FindByIdLocationUseCase>();
      final params = await context.parseUri(id);

      final response = await usecase(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get location',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> updateLocation(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.methodAllowed);
    } else {
      final usecase = context.read<UpdateLocationUseCase>();
      final paramsId = await context.parseUri(id);
      final params = await context.requestJSON();

      params
        ..remove('id')
        ..addEntries({'id': paramsId}.entries);

      final response = await usecase(Location.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update location',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> deleteLocation(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.methodAllowed);
    } else {
      final usecase = context.read<DeleteLocationByIdUseCase>();
      final paramsId = await context.parseUri(id);

      final response = await usecase(paramsId);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully delete location',
        ),
      );
    }
  }
}
