// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/users/data/models/user_model.dart';
import 'package:asset_management_api/features/users/data/source/user_local_data_source.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this._database);

  final DatabaseConfig _database;

  @override
  Future<UserModel> createUser(UserModel params) async {
    final db = await _database.database;

    final newUser = await db.transaction((txn) async {
      final checkUsername = await txn.query(
        'SELECT COUNT(id) FROM t_users WHERE = ?',
        [params.username],
      );

      if (checkUsername.first.isEmpty ||
          checkUsername.first.firstOrNull == null) {
        throw CreateException(
          message: 'Failed to create user, username already to exits',
        );
      }

      final id = await txn.query(
        '''
        INSERT INTO t_users (username, password, name, is_active, created_by)
        VALUES (?, ?, ?, ?, ?)
        ''',
        [
          params.username,
          params.password,
          params.name,
          params.isActive,
          params.createdBy,
        ],
      );

      if (id.insertId != null) {
        final newUser = await txn.query(
          'SELECT id, username, name, FROM t_users WHERE id = ?',
          [id],
        );

        return newUser.first.fields;
      } else {
        throw CreateException(
          message: 'Failed to create new user, please try again',
        );
      }
    });

    return UserModel.fromMap(newUser!);
  }

  @override
  Future<List<UserModel>> findAllUser() {
    // TODO: implement findAllUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> findByIdUser(int params) {
    // TODO: implement findByIdUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> login(
      {required String username, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<UserModel> updateUser(UserModel params) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
