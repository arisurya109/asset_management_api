// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/reprint/domain/usecases/reprint_asset_use_case.dart';
import 'package:asset_management_api/features/reprint/domain/usecases/reprint_location_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class ReprintResponse {
  ReprintResponse._();

  static Future<Response> asset(RequestContext context, String query) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<ReprintAssetUseCase>();
      final failureOrResponse = await usecase(query);

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully find asset',
          body: response,
        ),
      );
    }
  }

  static Future<Response> location(
    RequestContext context,
    String query,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<ReprintLocationUseCase>();
      final failureOrResponse = await usecase(query);

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully find location',
          body: response,
        ),
      );
    }
  }
}
