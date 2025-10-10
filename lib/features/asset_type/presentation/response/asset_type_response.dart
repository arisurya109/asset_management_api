// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_type/domain/entities/asset_type.dart';
import 'package:asset_management_api/features/asset_type/domain/usecases/create_asset_type_use_case.dart';
import 'package:asset_management_api/features/asset_type/domain/usecases/find_all_asset_type_use_case.dart';
import 'package:asset_management_api/features/asset_type/domain/usecases/find_by_id_asset_type_use_case.dart';
import 'package:asset_management_api/features/asset_type/domain/usecases/update_asset_type_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AssetTypeResponse {
  AssetTypeResponse._();

  static Future<Response> createAssetType(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateAssetTypeUseCase>();
      final params = await context.requestJSON();

      final response = await usecase(AssetType.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create asset type',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> updateAssetType(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateAssetTypeUseCase>();
      final params = await context.requestJSON();
      final paramsId = await context.parseUri(id);

      params
        ..remove('id')
        ..addEntries({'id': paramsId}.entries);

      final response = await usecase(AssetType.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update asset type',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findByIdAssetType(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindByIdAssetTypeUseCase>();
      final paramsId = await context.parseUri(id);

      final response = await usecase(paramsId);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get asset type',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAllAssetType(
    RequestContext context,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllAssetTypeUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all asset type',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }
}
