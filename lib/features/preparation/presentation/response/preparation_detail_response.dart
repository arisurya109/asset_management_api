// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/add_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/get_preparation_details_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class PreparationDetailResponseUser {
  PreparationDetailResponseUser._();

  static Future<Response> addPreparationDetail(
    RequestContext context,
    int id,
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
      final jsonMap = await context.requestJSON();

      final userId = await jwt.getIdUser(context);

      jsonMap.addAll({
        'preparation_id': id,
      });

      final usecase = context.read<AddPreparationDetailUseCase>();

      final params = PreparationDetail.fromJsonAdd(jsonMap);

      final paramsIsValid = params.validateAdd();

      if (paramsIsValid != null) {
        return ResponseHelper.badRequest(description: paramsIsValid);
      }

      final failureOrResponse = await usecase(
        params: params,
        userId: userId,
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(
          description: failure.message!,
        ),
        (response) => ResponseHelper.json(
          code: HttpStatus.created,
          status: response,
        ),
      );
    }
  }

  static Future<Response> findPreparationDetails(
    RequestContext context,
    int id,
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
      final usecase = context.read<GetPreparationDetailsUseCase>();

      final failureOrPreparation = await usecase(
        preparationId: id,
      );

      return failureOrPreparation.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (preparation) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get preparation details',
          body: preparation.toJson(),
        ),
      );
    }
  }
}
