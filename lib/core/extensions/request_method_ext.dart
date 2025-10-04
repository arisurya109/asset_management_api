// ignore_for_file: public_member_api_docs

import 'package:dart_frog/dart_frog.dart';

extension RequestMethodExt on RequestContext {
  Future<Map<String, dynamic>> requestJSON() async {
    final json = await request.json();
    return json as Map<String, dynamic>;
  }

  Future<int> parseUri(String id) async {
    return int.parse(id);
  }

  Future<String?> bindQuery(String param) async {
    final query = request.uri.queryParameters[param];
    return query;
  }

  bool get contentTypeJson =>
      request.headers['content-type'] == 'application/json';

  bool get httpMethodGet => request.method == HttpMethod.get;
  bool get httpMethodPost => request.method == HttpMethod.post;
  bool get httpMethodPut => request.method == HttpMethod.put;
  bool get httpMethodDelete => request.method == HttpMethod.delete;
  bool get httpMethodPatch => request.method == HttpMethod.patch;
}
