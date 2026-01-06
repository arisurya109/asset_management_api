// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/location/domain/entities/location.dart';
import 'package:asset_management_api/features/location/domain/usecases/create_location_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/delete_location_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_all_location_type_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_all_location_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_by_id_location_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_by_pagination_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_by_query_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_non_storage_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_storage_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/update_location_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class LocationResponse {
  LocationResponse._();

  static Future<Response> createLocation(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'add',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final params = await context.requestJSON();

      final paramsLocation = Location.fromRequest(params);

      final validateRequest = paramsLocation.checkCreateRequest();

      if (validateRequest != null) {
        return ResponseHelper.badRequest(
          description: validateRequest,
        );
      }

      final usecase = context.read<CreateLocationUseCase>();
      final userId = await jwt.getIdUser(context);

      final response = await usecase(paramsLocation, userId);

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

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'view',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
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

  static Future<Response> findByIdLocation(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'view',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
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

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'update',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
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

  static Future<Response> findLocationByQuery(
    RequestContext context,
    String query,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'view',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<FindLocationByQueryUseCase>();

      final response = await usecase(query);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully find location by query',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findLocationByStorage(
    RequestContext context,
    String query,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'view',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecaseStorage = context.read<FindLocationStorageUseCase>();
      final usecaseNonStorage = context.read<FindLocationNonStorageUseCase>();

      if (query == '1') {
        final response = await usecaseStorage();

        return response.fold(
          (l) => ResponseHelper.badRequest(description: l.message!),
          (r) => ResponseHelper.json(
            code: HttpStatus.ok,
            status: 'Successfully find location by storage',
            body: r.map((e) => e.toResponse()).toList(),
          ),
        );
      } else {
        final response = await usecaseNonStorage();

        return response.fold(
          (l) => ResponseHelper.badRequest(description: l.message!),
          (r) => ResponseHelper.json(
            code: HttpStatus.ok,
            status: 'Successfully find location by non storage',
            body: r.map((e) => e.toResponse()).toList(),
          ),
        );
      }
    }
  }

  static Future<Response> findAllLocationType(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'add',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<FindAllLocationTypeUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully find location type',
          body: r,
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

    final verifyAccess =
        await jwt.checkPermissionUser(context, 'master', 'delete');

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!verifyAccess) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<DeleteLocationUseCase>();

      final locationId = await context.parseUri(id);
      final userId = await jwt.getIdUser(context);

      final response = await usecase(id: locationId, userId: userId);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: r,
        ),
      );
    }
  }

  static Future<Response> findLocationByPagination(
    RequestContext context,
    String? query,
    String limit,
    String page,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'view',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<FindLocationByPaginationUseCase>();

      final paramsLimit = await context.parseUri(limit);
      final paramsPage = await context.parseUri(page);

      final response = await usecase(
        limit: paramsLimit,
        page: paramsPage,
        query: query,
      );

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => Response.json(
          body: r.toJson(),
        ),
      );
    }
  }
}
