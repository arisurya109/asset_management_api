// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:dart_frog/dart_frog.dart';

extension ContentTypeExt on RequestContext {
  bool get contentTypeJSON =>
      request.headers['content-type'] == Constant.applicationJson;
}
