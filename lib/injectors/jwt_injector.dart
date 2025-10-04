// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler jwtInjector(Handler handler) {
  return handler.use(provider<JwtService>((_) => jwtService));
}
