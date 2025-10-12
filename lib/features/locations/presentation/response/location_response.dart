import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/locations/domain/entities/location.dart';
import 'package:asset_management_api/features/locations/domain/usecases/create_location_box_use_case.dart';
import 'package:asset_management_api/features/locations/domain/usecases/create_location_detail_use_case.dart';
import 'package:asset_management_api/features/locations/domain/usecases/create_location_rack_use_case.dart';
import 'package:asset_management_api/features/locations/domain/usecases/create_location_team_use_case.dart';
import 'package:asset_management_api/features/locations/domain/usecases/create_location_use_case.dart';
import 'package:asset_management_api/features/locations/domain/usecases/find_all_location_box_use_case.dart';
import 'package:asset_management_api/features/locations/domain/usecases/find_all_location_detail_use_case.dart';
import 'package:asset_management_api/features/locations/domain/usecases/find_all_location_rack_use_case.dart';
import 'package:asset_management_api/features/locations/domain/usecases/find_all_location_team_use_case.dart';
import 'package:asset_management_api/features/locations/domain/usecases/find_all_location_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class LocationResponse {
  LocationResponse._();

  static Future<Response> createLocation(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final params = await context.requestJSON();
      final usecase = context.read<CreateLocationUseCase>();

      final response = await usecase(Location.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create location',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> createLocationDetail(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final params = await context.requestJSON();
      final usecase = context.read<CreateLocationDetailUseCase>();

      final response = await usecase(LocationDetail.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create location detail',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> createLocationTeam(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final params = await context.requestJSON();
      final usecase = context.read<CreateLocationTeamUseCase>();

      final response = await usecase(LocationTeam.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create location team',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> createLocationRack(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final params = await context.requestJSON();
      final usecase = context.read<CreateLocationRackUseCase>();

      final response = await usecase(LocationRack.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create location rack',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> createLocationBox(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final params = await context.requestJSON();
      final usecase = context.read<CreateLocationBoxUseCase>();

      final response = await usecase(LocationBox.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create location box',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAllLocation(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
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

  static Future<Response> findAllLocationTeam(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllLocationTeamUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all location team',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findAllLocationRack(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllLocationRackUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all location rack',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findAllLocationBox(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllLocationBoxUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all location box',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }
}
