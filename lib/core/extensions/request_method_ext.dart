// ignore_for_file: public_member_api_docs

import 'package:dart_frog/dart_frog.dart';

extension RequestMethodExt on RequestContext {
  bool get httpMethodGet => request.method == HttpMethod.get;
  bool get httpMethodPost => request.method == HttpMethod.post;
  bool get httpMethodPut => request.method == HttpMethod.put;
  bool get httpMethodDelete => request.method == HttpMethod.delete;
}
