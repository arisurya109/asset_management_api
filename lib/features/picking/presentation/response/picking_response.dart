// ignore_for_file: lines_longer_than_80_chars, public_member_api_docs, unnecessary_await_in_return

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_detail_item.dart';
import 'package:asset_management_api/features/picking/domain/usecases/find_all_picking_task_use_case.dart';
import 'package:asset_management_api/features/picking/domain/usecases/find_picking_detail_use_case.dart';
import 'package:asset_management_api/features/picking/domain/usecases/picked_asset_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_preparation_status_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class PickingResponse {
  PickingResponse._();

  static Future<Response> findAllTaskPicking(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllPickingTaskUseCase>();

      final userId = await jwt.getIdUser(context);

      final failureOrPickingList = await usecase(userId: userId);

      return failureOrPickingList.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (pickingList) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all picking tasks',
          body: pickingList.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> findPickingDetail(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindPickingDetailUseCase>();

      final userId = await jwt.getIdUser(context);

      final params = await context.parseUri(id);

      final failureOrPickingDetail = await usecase(
        userId: userId,
        params: params,
      );

      return failureOrPickingDetail.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (pickingDetail) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get picking detail',
          body: pickingDetail.toJson(),
        ),
      );
    }
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
      final usecase = context.read<UpdatePreparationStatusUseCase>();

      final userId = await jwt.getIdUser(context);

      final idPrep = await context.parseUri(id);

      final json = await context.requestJSON();

      final failureOrPickingDetail = await usecase(
        id: idPrep,
        userId: userId,
        params: json['status'] as String,
        temporaryLocationId: json['temporary_location_id'] as int?,
      );

      return failureOrPickingDetail.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (pickingDetail) => ResponseHelper.json(
          code: HttpStatus.ok,
          status:
              'Successfully update status ${pickingDetail.code} to ${pickingDetail.status}',
        ),
      );
    }
  }

  static Future<Response> pickedAsset(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<PickedAssetUseCase>();

      final userId = await jwt.getIdUser(context);

      final json = await context.requestJSON();

      final params = PickingDetailItem.fromJson(json);

      final validateParams = params.validatePickAsset();

      if (validateParams != null) {
        return ResponseHelper.badRequest(description: validateParams);
      }

      final failureOrResponse = await usecase(
        userId: userId,
        params: params,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: response,
        ),
      );
    }
  }
}
