// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_brand/domain/entities/asset_brand.dart';
import 'package:asset_management_api/features/asset_brand/domain/usecases/create_asset_brand_use_case.dart';
import 'package:asset_management_api/features/asset_brand/domain/usecases/find_all_asset_brand_use_case.dart';
import 'package:asset_management_api/features/asset_brand/domain/usecases/find_by_id_asset_brand_use_case.dart';
import 'package:asset_management_api/features/asset_brand/domain/usecases/update_asset_brand_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AssetBrandResponse {
  AssetBrandResponse._();

  static Future<Response> createAssetBrand(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateAssetBrandUseCase>();
      final params = await context.requestJSON();

      final response = await usecase(AssetBrand.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create new brand',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAllAssetBrand(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllAssetBrandUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all brand',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> updateAssetBrand(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateAssetBrandUseCase>();
      final params = await context.requestJSON();
      final paramsId = await context.parseUri(id);

      params
        ..remove('id')
        ..addEntries({'id': paramsId}.entries);

      final response = await usecase(AssetBrand.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update asset brand',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findByIdAssetBrand(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindByIdAssetBrandUseCase>();
      final paramsId = await context.parseUri(id);

      final response = await usecase(paramsId);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get asset brand',
          body: r.toResponse(),
        ),
      );
    }
  }
}
