// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

class ResponseHelper {
  ResponseHelper._();

  static Future<Response> badRequest({
    required String description,
  }) async {
    return ResponseHelper.responseFailure(
      code: HttpStatus.badRequest,
      status: 'Invalid Request',
      description: description,
    );
  }

  static Future<Response> unAuthorized({
    required String description,
  }) async {
    return ResponseHelper.responseFailure(
      code: HttpStatus.unauthorized,
      status: 'Akses Denied',
      description: description,
    );
  }

  static Future<Response> methodNotAllowed({
    required String description,
  }) async {
    return ResponseHelper.responseFailure(
      code: HttpStatus.methodNotAllowed,
      status: 'Method not allowed',
      description: description,
    );
  }

  static Future<Response> notFound({
    required String description,
  }) async {
    return ResponseHelper.responseFailure(
      code: HttpStatus.notFound,
      status: 'Not Found',
      description: description,
    );
  }

  static Future<Response> responseFailure({
    required int code,
    required String status,
    required String description,
  }) async {
    return Response.json(
      statusCode: code,
      body: {
        'error': {
          'status': status,
          'description': description,
        },
      },
    );
  }

  static Future<Response> json({
    required int code,
    required String status,
    Object? body,
    String? token,
  }) async {
    final responseBody = <String, dynamic>{
      'status': status,
      if (token != null) 'token': token,
      if (body != null) 'data': body,
    };

    return Response.json(
      statusCode: code,
      body: responseBody,
    );
  }
}
