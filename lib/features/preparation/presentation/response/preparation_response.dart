// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_request.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_pagination_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/get_preparation_types_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_preparation_status_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class PreparationResponse {
  PreparationResponse._();

  static Future<Response> createPreparation(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'preparation',
      'add',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final jsonMap = await context.requestJSON();

      final userId = await jwt.getIdUser(context);

      jsonMap.addAll({
        'created': userId,
      });

      final params = PreparationRequest.jsonCreate(jsonMap);

      final validateParams = params.validateCreateRequest();

      if (validateParams != null) {
        return ResponseHelper.badRequest(description: validateParams);
      }

      final usecase = context.read<CreatePreparationUseCase>();

      final failureOrPreparation = await usecase(
        params: params,
      );

      return failureOrPreparation.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (preparation) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create preparation',
          body: preparation.toJson(),
        ),
      );
    }
  }

  static Future<Response> findPreparationByPagination(
    RequestContext context,
    String? query,
    String limit,
    String page,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'preparation',
      'view',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<FindPreparationByPaginationUseCase>();

      final failureOrPreparation = await usecase(
        limit: int.parse(limit),
        page: int.parse(page),
        query: query,
      );

      return failureOrPreparation.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (preparation) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get preparations',
          body: preparation.toJson(),
        ),
      );
    }
  }

  static Future<Response> updatePreparation(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'preparation',
      'update',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final jsonMap = await context.requestJSON();

      final userId = await jwt.getIdUser(context);

      final paramsId = await context.parseUri(id);

      final usecase = context.read<UpdatePreparationStatusUseCase>();

      final params = PreparationRequest.jsonUpdate(
        {'id': paramsId, 'status': jsonMap['status']},
      );

      final failureOrPreparation = await usecase(
        params: params,
        userId: userId,
      );

      return failureOrPreparation.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (preparation) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update preparation',
          body: preparation.toJson(),
        ),
      );
    }
  }

  static Future<Response> getPreparationTypes(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'preparation',
      'add',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<GetPreparationTypesUseCase>();

      final failureOrTypes = await usecase();

      return failureOrTypes.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (preparation) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get preparation types',
          body: preparation,
        ),
      );
    }
  }
}
