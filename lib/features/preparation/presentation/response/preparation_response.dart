// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_assigned_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_cancelled_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_completed_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_picking_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_preparation_approved_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_status_ready_preparation_use_case.dart';
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
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindPreparationByIdUseCase>();

      final params = await context.parseUri(id);

      final failureOrResponse = await usecase(
        params: params,
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

  static Future<Response> updateStatusAssigned(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateStatusAssignedPreparationUseCase>();
      final userId = await jwt.getIdUser(context);
      final paramsId = await context.parseUri(id);

      final failureOrResponse = await usecase(
        id: paramsId,
        userId: userId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(
          description: failure.message!,
        ),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully assigned preparation',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> updateStatusCancelled(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateStatusCancelledPreparationUseCase>();
      final userId = await jwt.getIdUser(context);
      final paramsId = await context.parseUri(id);

      final failureOrResponse = await usecase(
        id: paramsId,
        userId: userId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(
          description: failure.message!,
        ),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully cancelled preparation',
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
      return ResponseHelper.unAuthorized(
        description: ErrorMsg.unAuthorized,
      );
    }

    final usecase = context.read<UpdateStatusCompletedPreparationUseCase>();

    Map<String, dynamic> body;
    try {
      body = await context.request.json() as Map<String, dynamic>;
    } catch (e) {
      return ResponseHelper.badRequest(description: 'Invalid JSON body');
    }

    if (!body.containsKey('data') ||
        !body.containsKey('file_name') ||
        !body.containsKey('file_base64')) {
      return ResponseHelper.badRequest(
        description: 'Missing data, file_name or file_base64',
      );
    }

    final fileName = body['file_name'] as String;
    final fileBase64 = body['file_base64'] as String;

    List<int> fileBytes;

    try {
      fileBytes = base64Decode(fileBase64);
    } catch (e) {
      return ResponseHelper.badRequest(
        description: 'Invalid Base64 format',
      );
    }

    final paramsId = await context.parseUri(id);
    final userId = await jwt.getIdUser(context);

    final result = await usecase(
      id: paramsId,
      userId: userId,
      fileBytes: fileBytes,
      originalName: fileName,
    );

    return result.fold(
      (failure) => ResponseHelper.badRequest(description: failure.message!),
      (data) => ResponseHelper.json(
        code: HttpStatus.ok,
        status: 'Successfully preparation completed',
        body: data.toJson(),
      ),
    );
  }

  static Future<Response> updateStatusPicking(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateStatusPickingPreparationUseCase>();
      final userId = await jwt.getIdUser(context);
      final paramsId = await context.parseUri(id);

      final failureOrResponse = await usecase(
        id: paramsId,
        userId: userId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(
          description: failure.message!,
        ),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully start picking',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> updateStatusApproved(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateStatusPreparationApprovedUseCase>();
      final userId = await jwt.getIdUser(context);
      final paramsId = await context.parseUri(id);

      final failureOrResponse = await usecase(
        id: paramsId,
        userId: userId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(
          description: failure.message!,
        ),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully approved preparation',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> updateStatusReady(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateStatusReadyPreparationUseCase>();
      final userId = await jwt.getIdUser(context);
      final paramsId = await context.parseUri(id);
      final json = await context.requestJSON();

      final locationId = json['location_id'] as int;
      final totalBox = json['total_box'] as int;

      final failureOrResponse = await usecase(
        id: paramsId,
        userId: userId,
        locationId: locationId,
        totalBox: totalBox,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(
          description: failure.message!,
        ),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully ready preparation',
          body: response.toJson(),
        ),
      );
    }
  }
}
