// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_categories/domain/entities/asset_category.dart';
import 'package:asset_management_api/features/asset_categories/domain/usecases/create_asset_category_use_case.dart';
import 'package:asset_management_api/features/asset_categories/domain/usecases/find_all_asset_category_use_case.dart';
import 'package:asset_management_api/features/asset_categories/domain/usecases/find_asset_category_by_query_use_case.dart';
import 'package:asset_management_api/features/asset_categories/domain/usecases/find_by_id_asset_category_use_case.dart';
import 'package:asset_management_api/features/asset_categories/domain/usecases/update_asset_category_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AssetCategoryResponse {
  AssetCategoryResponse._();

  static Future<Response> createAssetCategory(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'add',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<CreateAssetCategoryUseCase>();
      final params = await context.requestJSON();

      final response = await usecase(
        AssetCategory.fromRequest(params),
      );

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create asset category',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAllAssetCategory(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'view',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<FindAllAssetCategoryUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all asset category',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findByIdAssetCategory(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'view',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<FindByIdAssetCategoryUseCase>();
      final params = await context.parseUri(id);

      final response = await usecase(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get asset category',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> updateAssetCategory(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'update',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<UpdateAssetCategoryUseCase>();
      final paramsId = await context.parseUri(id);
      final params = await context.requestJSON();

      params
        ..remove('id')
        ..addEntries({'id': paramsId}.entries);

      final response = await usecase(AssetCategory.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update asset category',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAssetCategoryByQuery(
    RequestContext context,
    String params,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    final validatePermission = await jwt.checkPermissionUser(
      context,
      'master',
      'view',
    );

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else if (!validatePermission) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.notAccessModul);
    } else {
      final usecase = context.read<FindAssetCategoryByQueryUseCase>();

      final response = await usecase(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get asset category query',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }
}
