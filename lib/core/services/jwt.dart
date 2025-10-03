// ignore_for_file: public_member_api_docs

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

abstract class JwtService {
  Future<String> generateToken(Map<String, dynamic> code);
  Future<bool> verifyToken(RequestContext context);
}

class JwtServiceImpl implements JwtService {
  @override
  Future<String> generateToken(Map<String, dynamic> code) async {
    final jwt = JWT(code);

    final token = jwt.sign(
      SecretKey('secret-key'),
      expiresIn: const Duration(hours: 8),
    );

    return token;
  }

  @override
  Future<bool> verifyToken(RequestContext context) async {
    try {
      final headers = context.request.headers;

      final token = await _validateHeadersAndGetToken(headers);

      if (token != null) {
        JWT.verify(token, SecretKey('secret-key'));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String?> _validateHeadersAndGetToken(
    Map<String, dynamic> headers,
  ) async {
    String? token;

    if (headers.containsKey('authorization')) {
      final header = headers['authorization'].toString().split(' ');
      if (header[0].contains('Bearer')) {
        token = header[1];
      }
    }
    return token;
  }
}
