// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_request.dart';
import 'package:asset_management_api/features/assets/domain/usecases/create_asset_transfer_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/create_assets_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_all_assets_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_detail_by_id_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AssetsResponseUser {
  AssetsResponseUser._();

  static Future<Response> findAllAssets(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllAssetsUseCase>();

      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all asset',
          body: r.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> createAssets(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateAssetsUseCase>();

      final params = await context.requestJSON();
      final idUser = await jwt.getIdUser(context);

      print(params);

      params
        ..remove('registred_by')
        ..addEntries({'registred_by': idUser}.entries);

      final newParams = AssetsRequest.fromJson(params);

      final response = await usecase(newParams);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) {
          print(r.toJson());
          return ResponseHelper.json(
            code: HttpStatus.created,
            status: 'Successfully create asset',
            body: r.toJson(),
          );
        },
      );
    }
  }

  static Future<Response> findAssetDetailById(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAssetDetailByIdUseCase>();

      final params = await context.parseUri(id);

      final response = await usecase(params);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get asset detail',
          body: r.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> createAssetTransfer(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateAssetTransferUseCase>();
      final params = await context.requestJSON();
      final idUser = await jwt.getIdUser(context);
      final paramsId = await context.parseUri(id);

      final failureOrAsset = await usecase(
        assetId: paramsId,
        fromLocationId: params['from_location_id'] as int,
        toLocationId: params['to_location_id'] as int,
        movementById: idUser,
        movementType: params['movement_type'] as String,
        quantity: params['quantity'] as int,
        notes: params['notes'] as String?,
      );

      return failureOrAsset.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (assets) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully transfer asset',
          body: assets.toJson(),
        ),
      );
    }
  }
}
