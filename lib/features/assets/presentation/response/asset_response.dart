// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/assets/domain/entities/asset.dart';
import 'package:asset_management_api/features/assets/domain/usecases/create_asset_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_all_asset_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_by_id_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/update_asset_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AssetResponse {
  const AssetResponse._();

  static Future<Response> createAsset(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateAssetUseCase>();

      final params = await context.requestJSON();

      final response = await usecase(Asset.fromMap(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create new asset',
          body: r.toMap(),
        ),
      );
    }
  }

  static Future<Response> findAllAsset(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllAssetUseCase>();
      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully get all asset',
          body: r.map((e) => e.toMap()).toList(),
        ),
      );
    }
  }

  static Future<Response> findAssetById(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAssetByIdUseCase>();
      final idParams = await context.parseUri(id);

      final response = await usecase(idParams);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully get asset',
          body: r.toMap(),
        ),
      );
    }
  }

  static Future<Response> updateAsset(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateAssetUseCase>();

      final params = await context.requestJSON();

      final idParams = await context.parseUri(id);

      params
        ..remove('id')
        ..addEntries({'id': idParams}.entries);

      final response = await usecase(Asset.fromMap(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully update asset',
          body: r.toMap(),
        ),
      );
    }
  }
}
