// ignore_for_file: avoid_print, public_member_api_docs, avoid_redundant_argument_values
import 'package:asset_management_api/core/config/database_helper.dart';
// import 'package:dotenv/dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Database {
  factory Database() => _instance;

  Database._internal();

  static final Database _instance = Database._internal();

  MySqlConnection? _connection;

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
          host: DatabaseHelper.dbHOST,
          user: DatabaseHelper.dbUSER,
          password: DatabaseHelper.dbPASSWORD,
          db: DatabaseHelper.dbNAME,
          port: DatabaseHelper.dbPORT,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}

class DatabaseErpOld {
  factory DatabaseErpOld() => _instance;

  DatabaseErpOld._internal();

  static final DatabaseErpOld _instance = DatabaseErpOld._internal();

  MySqlConnection? _connection;

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
          host: DatabaseHelper.dbHOST,
          user: DatabaseHelper.dbUSER,
          password: DatabaseHelper.dbPASSWORD,
          db: DatabaseHelper.dbNAMEOLD,
          port: DatabaseHelper.dbPORT,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
