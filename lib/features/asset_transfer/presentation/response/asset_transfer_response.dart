// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:asset_management_api/features/asset_transfer/domain/usecases/create_asset_transfer_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AssetTransferResponse {
  AssetTransferResponse._();

  static Future<Response> createAssetTransfer(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final idUser = await jwt.getIdUser(context);
      final usecase = context.read<CreateAssetTransferUseCase>();
      final params = await context.requestJSON();

      params
        ..remove('movement_by_id')
        ..addEntries({'movement_by_id': idUser}.entries);

      final response = await usecase(AssetTransfer.fromRequest(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully transfer asset to location ${r.fromLocation}',
          body: r.toResponse(),
        ),
      );
    }
  }
}
