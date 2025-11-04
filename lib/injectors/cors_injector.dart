// ignore_for_file: public_member_api_docs

import 'package:dart_frog/dart_frog.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

Handler corsInjector(Handler handler) {
  return handler.use(
    fromShelfMiddleware(
      corsHeaders(
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods':
              'POST, GET, OPTIONS, PUT, PATCH, DELETE, HEAD',
        },
      ),
    ),
  );
}
