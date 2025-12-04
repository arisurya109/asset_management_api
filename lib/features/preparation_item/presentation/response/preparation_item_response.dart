// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/preparation_item/domain/entities/preparation_item.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/create_preparation_item_use_case.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/delete_preparation_item_use_case.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/find_all_preparation_item_by_preparation_detail_id_use_case.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/find_all_preparation_item_by_preparation_id_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class PreparationItemResponse {
  PreparationItemResponse._();

  static Future<Response> createPreparationItem(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreatePreparationItemUseCase>();

      final params = await context.requestJSON();

      final userId = await jwt.getIdUser(context);

      final paramsEntity = PreparationItem.fromJson(params)
        ..pickedById = userId;

      final failureOrResponse = await usecase(
        params: paramsEntity,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully insert preparation items',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> deletePreparationItem(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<DeletePreparationItemUseCase>();

      final params = await context.parseUri(id);

      final failureOrResponse = await usecase(
        id: params,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully delete preparation items',
          body: response,
        ),
      );
    }
  }

  static Future<Response> findAllPreparationItemByDetailId(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase =
          context.read<FindAllPreparationItemByPreparationDetailIdUseCase>();

      final paramsDetailId = await context.parseUri(id);

      final failureOrResponse = await usecase(
        preparationDetailId: paramsDetailId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status:
              'Successfully get all preparation items by preparation detail id',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> findAllPreparationItemByPreparationId(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase =
          context.read<FindAllPreparationItemByPreparationIdUseCase>();

      final params = await context.parseUri(id);

      final failureOrResponse = await usecase(
        preparationId: params,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all preparation items by preparation id',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }
}
