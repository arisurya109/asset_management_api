// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:crypto/crypto.dart';

String hashPassword(String password) {
  final bytes = utf8.encode(password);

  final digest = sha256.convert(bytes);

  return digest.toString();
}
