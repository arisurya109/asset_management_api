// ignore_for_file: avoid_print, public_member_api_docs

import 'package:dotenv/dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Database {
  factory Database() => _instance;

  Database._internal() {
    _loadEnv();
  }

  static final Database _instance = Database._internal();

  late final DotEnv env;
  MySqlConnection? _connection;

  void _loadEnv() {
    env = DotEnv()..load();
  }

  Future<MySqlConnection> get connection async {
    _connection ??= await _connect();
    return _connection!;
  }

  Future<void> close() async {
    await _connection?.close();
    _connection = null;
  }

  Future<MySqlConnection?> _connect() async {
    try {
      return await MySqlConnection.connect(
        ConnectionSettings(
          host: env['DB_HOST']!,
          user: env['DB_USER'],
          password: env['DB_PASSWORD'],
          db: env['DB_NAME'],
          port: int.parse(env['DB_PORT']!),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
