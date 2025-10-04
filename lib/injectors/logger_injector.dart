// ignore_for_file: public_member_api_docs

import 'dart:developer';

import 'package:dart_frog/dart_frog.dart';

Handler logger(Handler handler) {
  return handler.use(
    requestLogger(logger: (message, isError) => log(message)),
  );
}
