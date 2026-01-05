// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_models/domain/entities/asset_model.dart';
import 'package:asset_management_api/features/asset_models/domain/usecases/create_asset_model_use_case.dart';
import 'package:asset_management_api/features/asset_models/domain/usecases/find_all_asset_model_use_case.dart';
import 'package:asset_management_api/features/asset_models/domain/usecases/find_asset_model_by_query_use_case.dart';
import 'package:asset_management_api/features/asset_models/domain/usecases/find_by_id_asset_model_use_case.dart';
import 'package:asset_management_api/features/asset_models/domain/usecases/update_asset_model_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AssetModelResponse {
  AssetModelResponse._();

  static Future<Response> createAssetModel(RequestContext context) async {
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
      final params = await context.requestJSON();
      final usecase = context.read<CreateAssetModelUseCase>();
      final id = await jwt.getIdUser(context);

      params
        ..remove('created_by')
        ..addEntries({'created_by': id}.entries);

      final response = await usecase(AssetModel.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create new asset model',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAllAssetModel(RequestContext context) async {
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
      final usecase = context.read<FindAllAssetModelUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all asset model',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }

  static Future<Response> findByIdAssetModel(
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
      final usecase = context.read<FindByIdAssetModelUseCase>();
      final params = await context.parseUri(id);

      final response = await usecase(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get asset model',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> updateAssetModel(
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
      final usecase = context.read<UpdateAssetModelUseCase>();
      final paramsId = await context.parseUri(id);
      final params = await context.requestJSON();

      params
        ..remove('id')
        ..addEntries({'id': paramsId}.entries);

      final response = await usecase(AssetModel.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully update asset model',
          body: r.toResponse(),
        ),
      );
    }
  }

  static Future<Response> findAssetModelByQuery(
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
      final usecase = context.read<FindAssetModelByQueryUseCase>();

      final response = await usecase(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully find asset model by query',
          body: r.map((e) => e.toResponse()).toList(),
        ),
      );
    }
  }
}
