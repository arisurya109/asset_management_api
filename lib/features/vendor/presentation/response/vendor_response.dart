import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/vendor/domain/entities/vendor.dart';
import 'package:asset_management_api/features/vendor/domain/usecases/create_vendor_use_case.dart';
import 'package:asset_management_api/features/vendor/domain/usecases/find_all_vendor_use_case.dart';
import 'package:asset_management_api/features/vendor/domain/usecases/update_vendor_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class VendorResponse {
  VendorResponse._();

  static Future<Response> createVendor(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateVendorUseCase>();
      final params = await context.requestJSON();
      final idUser = await jwt.getIdUser(context);

      params
        ..remove('created_by')
        ..addEntries({'created_by': idUser}.entries);

      final failureOrResponse = await usecase(
        Vendor.fromJson(params),
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create new vendor',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> updateVendor(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateVendorUseCase>();
      final params = await context.requestJSON();
      final idUser = await context.parseUri(id);

      params
        ..remove('updated_by')
        ..addEntries({'updated_by': idUser}.entries);

      final failureOrResponse = await usecase(
        Vendor.fromJson(params),
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully updated vendor',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> findAllVendor(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllVendorUseCase>();

      final failureOrResponse = await usecase();

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all vendor',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }
}
