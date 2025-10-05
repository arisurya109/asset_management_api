// ignore_for_file: public_member_api_docs

abstract class Constant {
  static const String applicationJson = 'application/json';

  static const String databaseName = 'asset_management_api_test';
  static const String userName = 'root';
  static const String password = '123456';
  static const String host = '127.0.0.1';
  static const int port = 3306;
}

abstract class ErrorMsg {
  static const String unAuthorized = 'Invalid token, please login again';
  static const String methodAllowed = 'Http method does not exist';
  static const String notAccessModul = 'You do not have access to this module.';
}
