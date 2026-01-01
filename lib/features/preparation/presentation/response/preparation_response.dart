// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_destination_external_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_destination_internal_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_code_or_destination_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_preparation_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class PreparationResponse {
  PreparationResponse._();

  static Future<Response> createPreparation(RequestContext context) async {
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
        params: paramsEntity,
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

  static Future<Response> findAllPreparation(RequestContext context) async {
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
    String params,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindPreparationByIdUseCase>();

      final id = await context.parseUri(params);

      final failureOrResponse = await usecase(
        params: id,
      );

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

  static Future<Response> findPreparationByCodeOrDestination(
    RequestContext context,
    String params,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindPreparationByCodeOrDestinationUseCase>();

      final failureOrResponse = await usecase(
        params: params,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get preparation by code or destination',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> updateStatusPreparation(
    RequestContext context,
    String params,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateStatusPreparationUseCase>();

      final userId = await jwt.getIdUser(context);

      final paramsMap = await context.requestJSON();

      final id = await context.parseUri(params);

      final failureOrResponse = await usecase(
        id: id,
        status: paramsMap['status'] as String,
        userId: userId,
        locationId: paramsMap['location_id'] as int?,
        remarks: paramsMap['remarks'] as String?,
        totalBox: paramsMap['total_box'] as int?,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update preparation',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> findDestinationByType(
    RequestContext context,
    String params,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecaseInternal = context.read<FindDestinationInternalUseCase>();
      final usecaseExternal = context.read<FindDestinationExternalUseCase>();

      final paramsType = params == 'I';

      if (paramsType) {
        final failureOrDestination = await usecaseInternal();

        return failureOrDestination.fold(
          (failure) => ResponseHelper.badRequest(
            description: failure.message!,
          ),
          (destination) => ResponseHelper.json(
            code: HttpStatus.ok,
            status: 'Successfully get destination internal',
            body: destination.map((e) => e.toResponse()).toList(),
          ),
        );
      } else {
        final failureOrDestination = await usecaseExternal();

        return failureOrDestination.fold(
          (failure) => ResponseHelper.badRequest(
            description: failure.message!,
          ),
          (destination) => ResponseHelper.json(
            code: HttpStatus.ok,
            status: 'Successfully get destination external',
            body: destination.map((e) => e.toResponse()).toList(),
          ),
        );
      }
    }
  }
}
