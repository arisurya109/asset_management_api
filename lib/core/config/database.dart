// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseConfig {
  DatabaseConfig._();

  MySqlConnection? _database;

  Future<MySqlConnection> get database async {
    if (_database != null) {
      _database = await _setConnection();
      return _database!;
    }
    return _database!;
  }

  Future<MySqlConnection> _setConnection() async {
    return MySqlConnection.connect(
      ConnectionSettings(
        db: Constant.databaseName,
        host: Constant.host,
        user: Constant.userName,
        password: Constant.password,
      ),
    );
  }
}
