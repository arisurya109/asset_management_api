// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/extensions/request_method_ext.dart';
import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:asset_management_api/core/helpers/response_helper.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/categories/domain/entities/category.dart';
import 'package:asset_management_api/features/categories/domain/usecases/create_category_use_case.dart';
import 'package:asset_management_api/features/categories/domain/usecases/find_all_category_use_case.dart';
import 'package:asset_management_api/features/categories/domain/usecases/find_category_by_id_use_case.dart';
import 'package:asset_management_api/features/categories/domain/usecases/update_category_use_case.dart';
import 'package:dart_frog/dart_frog.dart';

class CategoryResponse {
  const CategoryResponse._();

  static Future<Response> createCategory(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<CreateCategoryUseCase>();

      final params = await context.requestJSON();

      final response = await usecase(Category.fromMap(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully create new category',
          body: r.toMap(),
        ),
      );
    }
  }

  static Future<Response> findAllCategory(RequestContext context) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindAllCategoryUseCase>();
      final response = await usecase();

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully get all category',
          body: r.map((e) => e.toMap()).toList(),
        ),
      );
    }
  }

  static Future<Response> findCategoryById(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<FindCategoryByIdUseCase>();
      final idParams = await context.parseUri(id);

      final response = await usecase(idParams);

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully get category',
          body: r.toMap(),
        ),
      );
    }
  }

  static Future<Response> updateCategory(
    RequestContext context,
    String id,
  ) async {
    final jwt = context.read<JwtService>();

    final validateToken = await jwt.verifyToken(context);

    if (!validateToken) {
      return ResponseHelper.unAuthorized(description: ErrorMsg.unAuthorized);
    } else {
      final usecase = context.read<UpdateCategoryUseCase>();

      final params = await context.requestJSON();

      final idParams = await context.parseUri(id);

      params
        ..remove('id')
        ..addEntries({'id': idParams}.entries);

      final response = await usecase(Category.fromMap(params));

      return response.fold(
        (l) => ResponseHelper.badRequest(description: l.message!),
        (r) => ResponseHelper.json(
          code: HttpStatus.created,
          status: 'Successfully update category',
          body: r.toMap(),
        ),
      );
    }
  }
}
