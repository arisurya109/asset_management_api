// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/purchase_order/domain/entities/purchase_order.dart';
import 'package:asset_management_api/features/purchase_order/domain/usecases/create_purchase_order_use_case.dart';
import 'package:asset_management_api/features/purchase_order/domain/usecases/find_all_purchase_order_use_case.dart';
import 'package:asset_management_api/features/purchase_order/domain/usecases/find_purchase_order_detail_item_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class PurchaseOrderResponse {
  PurchaseOrderResponse._();

  static Future<Response> createPurchaseOrder(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreatePurchaseOrderUseCase>();
      final params = await context.requestJSON();
      final userId = await jwt.getIdUser(context);

      params
        ..remove('created_by_id')
        ..addEntries({'created_by_id': userId}.entries);

      final failureOrResponse = await usecase(
        PurchaseOrder.fromJson(params),
      );

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create purchase order',
          body: response.toJson(),
        ),
      );
    }
  }

  static Future<Response> findAllPurchaseOrder(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllPurchaseOrderUseCase>();

      final failureOrResponse = await usecase();

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get all purchase order',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  static Future<Response> findPurchaseOrderDetailItem(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindPurchaseOrderDetailItemUseCase>();
      final params = await context.parseUri(id);
      final failureOrResponse = await usecase(params);

      return failureOrResponse.fold(
        (failure) => ResponseHelper.badRequest(description: failure.message!),
        (response) => ResponseHelper.json(
          code: HttpStatus.ok,
          status: 'Successfully get purchase order detail',
          body: response.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }
}
