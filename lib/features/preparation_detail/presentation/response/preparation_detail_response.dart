// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/preparation_detail/domain/entities/preparation_detail.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/create_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/find_all_preparation_detail_by_preparation_id_use_case.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/find_preparation_detail_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/update_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/update_status_completed_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation_detail/domain/usecases/update_status_progress_preparation_detail_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class PreparationDetailResponse {
  PreparationDetailResponse._();

  static Future<Response> createPreparationDetail(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreatePreparationDetailUseCase>();
      final params = await context.requestJSON();

      final paramsEntity = PreparationDetail.fromJson(params);

      final failureOrResponse = await usecase(
        params: paramsEntity,
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

      final failureOrResponse = await usecase(
        preparationId: params,
      );

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
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindPreparationDetailByIdUseCase>();

      final params = await context.parseUri(id);

      final failureOrResponse = await usecase(
        id: params,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get preparation detail by id',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> updatePreparationDetail(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdatePreparationDetailUseCase>();

      final params = await context.requestJSON();

      final paramsId = await context.parseUri(id);

      final paramsEntity = PreparationDetail.fromJson(params)..id = paramsId;

      final failureOrResponse = await usecase(
        params: paramsEntity,
      );

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

  static Future<Response> updateStatusCompleted(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase =
          context.read<UpdateStatusCompletedPreparationDetailUseCase>();
      final paramsId = await context.parseUri(id);
      final userId = await jwt.getIdUser(context);

      final failureOrResponse = await usecase(
        id: paramsId,
        userId: userId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully completed preparation detail',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> updateStatusProgress(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase =
          context.read<UpdateStatusProgressPreparationDetailUseCase>();
      final paramsId = await context.parseUri(id);
      final userId = await jwt.getIdUser(context);

      final failureOrResponse = await usecase(
        id: paramsId,
        userId: userId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully start picking',
          body: response.toJson(),
        ),
      );
    }
  }
}
