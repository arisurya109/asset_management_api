// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

abstract class JwtService {
  Future<String> generateToken(Map<String, dynamic> code);
  Future<bool> verifyToken(RequestContext context);
  Future<int> getIdUser(RequestContext context);
  Future<String> getUsername(RequestContext context);
  Future<bool> checkPermissionUser(
    RequestContext context,
    String module,
    String permission,
  );
}

class JwtServiceImpl implements JwtService {
  JwtServiceImpl(this._database);

  final Database _database;

  @override
  Future<String> generateToken(Map<String, dynamic> code) async {
    final jwt = JWT(code);

    final token = jwt.sign(
      SecretKey('c0b4d1b4c4'),
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
        JWT.verify(token, SecretKey('c0b4d1b4c4'));
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

  @override
  Future<int> getIdUser(RequestContext context) async {
    final headers = context.request.headers;

    final token = await _validateHeadersAndGetToken(headers);

    final jwt = JWT.decode(token!);

    // ignore: avoid_dynamic_calls
    return jwt.payload['id'] as int;
  }

  @override
  Future<bool> checkPermissionUser(
    RequestContext context,
    String module,
    String permission,
  ) async {
    final idUser = await getIdUser(context);

    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT 
        CASE 
          WHEN EXISTS (
            SELECT 1 
            FROM t_user_permission_module AS upm
            JOIN t_module_permission AS mp ON upm.module_permission_id = mp.id
            JOIN t_modules AS m ON mp.module_id = m.id
            JOIN t_permissions AS p ON mp.permission_id = p.id
            WHERE upm.user_id = ? 
              AND m.module_name = ? 
              AND p.permission_name = ?
        ) THEN 1 
        ELSE 0 
      END AS access
      ''',
      [idUser, module, permission],
    );

    if (response.first.fields['access'] == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<String> getUsername(RequestContext context) async {
    final db = await _database.connection;

    final idUser = await getIdUser(context);

    final response = await db.query(
      'SELECT username FROM t_users WHERE id = ?',
      [idUser],
    );

    return response.first.fields['username'] as String;
  }
}
