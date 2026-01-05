// ignore_for_file: unnecessary_await_in_return, public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/movement/domain/entities/movement.dart';
import 'package:asset_management_api/features/movement/domain/usecases/create_movement_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class MovementResponse {
  MovementResponse._();

  static Future<Response> movementTransfer(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return await ResponseHelper.unAuthorized(
        description: ErrorMsg.unAuthorized,
      );
    } else {
      final paramsJson = await context.requestJSON();
      final userId = await jwt.getIdUser(context);
      final assetId = await context.parseUri(id);
      paramsJson.addAll({
        'asset_id': assetId,
        'type': 'TRANSFER',
      });
      final params = Movement.fromJson(paramsJson);

      final validateRequest = params.validateRequest();

      if (validateRequest != null) {
        return ResponseHelper.badRequest(description: validateRequest);
      }

      final usecase = context.read<CreateMovementUseCase>();

      final failureOrResponse = await usecase(
        params: params,
        userId: userId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(
          description: failure.message!,
        ),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: response,
        ),
      );
    }
  }

  static Future<Response> movementPreparation(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return await ResponseHelper.unAuthorized(
        description: ErrorMsg.unAuthorized,
      );
    } else {
      final paramsJson = await context.requestJSON();

      final userId = await jwt.getIdUser(context);

      final assetId = await context.parseUri(id);

      paramsJson.addAll({
        'asset_id': assetId,
        'type': 'PREPARATION',
      });
      final params = Movement.fromJson(paramsJson);

      final validateRequest = params.validateRequest();

      if (validateRequest != null) {
        return ResponseHelper.badRequest(description: validateRequest);
      }

      final usecase = context.read<CreateMovementUseCase>();

      final failureOrResponse = await usecase(
        params: params,
        userId: userId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(
          description: failure.message!,
        ),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: response,
        ),
      );
    }
  }

  static Future<Response> movementReturn(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return await ResponseHelper.unAuthorized(
        description: ErrorMsg.unAuthorized,
      );
    } else {
      final paramsJson = await context.requestJSON();

      final userId = await jwt.getIdUser(context);

      final assetId = await context.parseUri(id);

      paramsJson.addAll({
        'asset_id': assetId,
        'type': 'RETURN',
      });
      final params = Movement.fromJson(paramsJson);

      final validateRequest = params.validateRequest();

      if (validateRequest != null) {
        return ResponseHelper.badRequest(description: validateRequest);
      }

      final usecase = context.read<CreateMovementUseCase>();

      final failureOrResponse = await usecase(
        params: params,
        userId: userId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(
          description: failure.message!,
        ),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: response,
        ),
      );
    }
  }
}
