// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_template.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_template_item.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_template_item_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/delete_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_template_item_by_template_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_template_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class PreparationResponse {
  PreparationResponse._();

  static Future<Response> createPreparationTemplate(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreatePreparationTemplateUseCase>();
      final params = await context.requestJSON();
      final userId = await jwt.getIdUser(context);

      params
        ..remove('created_by_id')
        ..addEntries({'created_by_id': userId}.entries);

      final failureOrResponse = await usecase(
        PreparationTemplate.fromJson(params),
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create template',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> createPreparationTemplateItem(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreatePreparationTemplateItemUseCase>();
      final params = await context.requestJSON();

      final paramsId = await context.parseUri(id);

      final failureOrResponse = await usecase(
        (params['data'] as List)
            .map(
              (e) =>
                  PreparationTemplateItem.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        paramsId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully insert template item',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> deletePreparationTemplate(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<DeletePreparationTemplateUseCase>();
      final params = await context.parseUri(id);

      final failureOrResponse = await usecase(params);

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: response,
        ),
      );
    }
  }

  static Future<Response> findAllPreparationTemplate(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllPreparationTemplateUseCase>();

      final failureOrResponse = await usecase();

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully Get All template',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> findAllPreparationTemplateItemByTemplateId(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase =
          context.read<FindAllPreparationTemplateItemByTemplateIdUseCase>();
      final params = await context.parseUri(id);

      final failureOrResponse = await usecase(params);

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully Get All template items',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }
}
