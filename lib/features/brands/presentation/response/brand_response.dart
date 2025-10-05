// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/brands/domain/entities/brand.dart';
import 'package:asset_management_api/features/brands/domain/usecases/create_brand_use_case.dart';
import 'package:asset_management_api/features/brands/domain/usecases/find_all_brand_use_case.dart';
import 'package:asset_management_api/features/brands/domain/usecases/find_brand_by_id_asset_use_case.dart';
import 'package:asset_management_api/features/brands/domain/usecases/find_brand_by_id_use_case.dart';
import 'package:asset_management_api/features/brands/domain/usecases/update_brand_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class BrandResponse {
  BrandResponse._();

  static Future<Response> createBrand(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateBrandUseCase>();
      final params = await context.requestJSON();

      final response = await usecase(Brand.fromRequest(params));

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

  static Future<Response> findAllBrand(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllBrandUseCase>();

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

  static Future<Response> findBrandByIdAsset(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindBrandByIdAssetUseCase>();
      final params = await context.parseUri(id);

      final response = await usecase(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get brand by id asset',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findBrandById(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindBrandByIdUseCase>();
      final params = await context.parseUri(id);

      final response = await usecase(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get brand by id',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> updateBrand(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateBrandUseCase>();
      final paramsId = await context.parseUri(id);
      final params = await context.requestJSON();

      params.addEntries({'id': paramsId}.entries);

      final response = await usecase(Brand.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update brand',
          body: r.toResponse(),
        ),
      );
    }
  }
}
