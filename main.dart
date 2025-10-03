import 'package:asset_management_api/core/helpers/constant.dart';
import 'package:mysql1/mysql1.dart';

void main() async {
  final testDb = TestConnectionDatabase();

  final connection = await testDb.getConnection();

  print(connection.query('DESCRIBE t_users'));
}

class TestConnectionDatabase {
  MySqlConnection? database;

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

  Future<MySqlConnection> getConnection() async {
    if (database == null) {
      database = await _setConnection();
      return database!;
    }
    return database!;
  }
}
