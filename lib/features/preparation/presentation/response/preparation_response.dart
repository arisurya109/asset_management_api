// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_item.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_template.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_template_item.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_item_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_template_item_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/delete_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_detail_by_preparation_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_item_by_preparation_detail_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_template_item_by_template_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_detail_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_preparation_use_case.dart';
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
          code: HttpStatus.ok,
          status: 'Successfully Get All template items',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> createPreparation(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreatePreparationUseCase>();
      final params = await context.requestJSON();
      final userId = await jwt.getIdUser(context);

      params.addEntries(
        {'created_by_id': userId}.entries,
      );

      final paramsEntity = Preparation.fromJson(params);

      final failureOrResponse = await usecase(
        paramsEntity,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create preparation',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> findAllPreparation(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllPreparationUseCase>();

      final failureOrResponse = await usecase();

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all preparation',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> findPreparationById(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindPreparationByIdUseCase>();

      final params = await context.parseUri(id);

      final failureOrResponse = await usecase(params);

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get preparation',
          body: response.toJson(),
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

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdatePreparationUseCase>();

      final idUser = await jwt.getIdUser(context);

      final params = await context.requestJSON();

      final paramsId = await context.parseUri(id);

      final paramsEntity = Preparation.fromJson(params)
        ..id = paramsId
        ..updatedById = idUser;

      final failureOrResponse = await usecase(paramsEntity);

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully updated preparation',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> createPreparationDetail(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreatePreparationDetailUseCase>();
      final params = await context.requestJSON();
      final prepId = await context.parseUri(id);

      final paramsEntity = PreparationDetail.fromJson(params)
        ..preparationId = prepId;

      final failureOrResponse = await usecase(
        paramsEntity,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully insert preparation detail',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> findAllPreparationDetailByPreparationId(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase =
          context.read<FindAllPreparationDetailByPreparationIdUseCase>();

      final params = await context.parseUri(id);

      final failureOrResponse = await usecase(params);

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all preparation detail by preparation id',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> findPreparationDetailById(
    RequestContext context,
    String id,
    String preparationId,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindPreparationDetailByIdUseCase>();

      final params = await context.parseUri(id);

      final prepId = await context.parseUri(preparationId);

      final failureOrResponse = await usecase(params, prepId);

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get preparation detail by  id',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> updatePreparationDetail(
    RequestContext context,
    String id,
    String preparationId,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdatePreparationDetailUseCase>();

      final params = await context.requestJSON();

      final paramsId = await context.parseUri(id);

      final prepId = await context.parseUri(preparationId);

      final paramsEntity = PreparationDetail.fromJson(params)
        ..id = paramsId
        ..preparationId = prepId;

      final failureOrResponse = await usecase(paramsEntity);

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully updated preparation detail',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> createPreparationItem(
    RequestContext context,
    String id,
    String preparationId,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreatePreparationItemUseCase>();

      final params = await context.requestJSON();

      final userId = await jwt.getIdUser(context);

      final paramsPrepId = await context.parseUri(preparationId);

      final paramsDetailId = await context.parseUri(id);

      final paramsEntity = PreparationItem.fromJson(params)
        ..pickedById = userId
        ..preparationId = paramsPrepId
        ..preparationDetailId = paramsDetailId;

      final failureOrResponse = await usecase(
        paramsEntity,
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

  static Future<Response> findAllPreparationItemByDetailId(
    RequestContext context,
    String id,
    String preparationId,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase =
          context.read<FindAllPreparationItemByPreparationDetailId>();

      final paramsDetailId = await context.parseUri(id);

      final failureOrResponse = await usecase(
        paramsDetailId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all preparation items',
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
          context.read<FindAllPreparationItemByPreparationDetailId>();

      final params = await context.parseUri(id);

      final failureOrResponse = await usecase(
        params,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all preparation items',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }
}
