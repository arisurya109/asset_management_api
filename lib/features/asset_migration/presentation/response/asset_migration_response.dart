// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_migration/domain/entities/asset_migration.dart';
import 'package:asset_management_api/features/asset_migration/domain/usecases/migration_asset_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class AssetMigrationResponse {
  AssetMigrationResponse._();

  static Future<Response> migrationAsset(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final idUser = await jwt.getIdUser(context);

      final params = await context.requestJSON();

      params
        ..remove('registred_by')
        ..addEntries({'registred_by': idUser}.entries);

      final usecase = context.read<MigrationAssetUseCase>();

      final response = await usecase(
        AssetMigration.fromMap(params),
      );

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully migration asset',
          body: r.toResponse(),
        ),
      );
    }
  }
}
