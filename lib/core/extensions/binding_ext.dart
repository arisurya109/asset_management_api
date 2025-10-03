// ignore_for_file: public_member_api_docs

import 'package:dart_frog/dart_frog.dart';

extension BindingExt on RequestContext {
  Future<Map<String, dynamic>> requestToJSON() async {
    final requestBody = await request.json();
    return requestBody as Map<String, dynamic>;
  }
}
