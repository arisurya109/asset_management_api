// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/helpers/hash_password.dart';
import 'package:asset_management_api/features/users/data/model/user_model.dart';
import 'package:asset_management_api/features/users/data/source/user_local_data_source.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<UserModel> createUser(UserModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final isUsernameExists = await txn.query(
        'SELECT COUNT(id) FROM t_users WHERE username = ?',
        [params.username],
      );

      if (isUsernameExists.first.fields['COUNT(id)'] as int > 0) {
        throw CreateException(
          message: 'Failed create new user, username already to exits',
        );
      } else {
        final insertedNewUser = await txn.query(
          '''
          INSERT INTO t_users (username, password, name, created_by)
          VALUES (?, ?, ?, ?)
          ''',
          [params.username, params.password, params.name, params.createdBy],
        );

        if (insertedNewUser.insertId == 0) {
          throw CreateException(
            message: 'Failed to create new user, please try again',
          );
        } else {
          for (final perm in params.modules!) {
            await txn.query(
              '''
              INSERT INTO t_user_permission_module (user_id, module_id, permission_id)
              VALUES (?, ?, ?)
              ''',
              [
                insertedNewUser.insertId,
                perm['module_id'],
                perm['permission_id'],
              ],
            );
          }
        }

        final responseUser = await txn.query(
          '''
          SELECT 
            u.id,
            u.username,
            u.name,
            u.created_by,
            u.is_active,
            u.created_at
          FROM t_users AS u
          WHERE u.username = ?
          ''',
          [params.username],
        );

        final responseModule = await txn.query(
          '''
          SELECT 
          CONCAT(m.module_name, '_', p.permission_name) AS module
          FROM t_user_permission_module upm
          JOIN t_modules m ON upm.module_id = m.id
          JOIN t_permissions p ON upm.permission_id = p.id
          WHERE upm.user_id = ?
          ORDER BY upm.module_id
          ''',
          [responseUser.first.fields['id']],
        );

        final newUser = responseUser.first.fields;

        final modules = responseModule.map((e) => e['module']).toList();

        newUser.addEntries({'modules': modules}.entries);
        return newUser;
      }
    });

    return UserModel.fromDatabase(response!);
  }

  @override
  Future<List<UserModel>> findAllUser(int idRequest) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT id, username, name, is_active, created_at, created_by 
      FROM t_users WHERE NOT id = ?
      ''',
      [idRequest],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(message: 'No user yet, please create user now');
    }

    return response.map((e) => UserModel.fromDatabase(e.fields)).toList();
  }

  @override
  Future<UserModel> findByIdUser(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT id, username, name, is_active, created_at, created_by
      FROM t_users WHERE id = ?
      ''',
      [params],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(message: 'User not found');
    }

    return UserModel.fromDatabase(response.first.fields);
  }

  @override
  Future<UserModel> updateStatusUser(int id, int params) async {
    final db = await _database.connection;

    final response = await db.query(
      'UPDATE t_users SET is_active = ? WHERE id = ?',
      [params, id],
    );

    if (response.affectedRows == 0) {
      throw UpdateException(message: 'Failed to update status user');
    }

    final newUser = await db.query(
      '''
      SELECT id, username, name, is_active, created_at, created_by
      FROM t_users WHERE id = ?
      ''',
      [id],
    );

    return UserModel.fromDatabase(newUser.first.fields);
  }

  @override
  Future<UserModel> updateUser(UserModel params) async {
    final db = await _database.connection;

    final response = await db.query(
      'UPDATE t_users SET password = ? WHERE id = ?',
      [hashPassword(params.password!), params.id],
    );

    if (response.affectedRows == 0) {
      throw UpdateException(message: 'Failed to update user');
    }

    final newUser = await db.query(
      '''
      SELECT id, username, name, is_active, created_at, created_by
      FROM t_users WHERE id = ?
      ''',
      [params.id],
    );

    return UserModel.fromDatabase(newUser.first.fields);
  }

  @override
  Future<String> changePassword(
    String username,
    String oldPassword,
    String newPassword,
  ) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final responseUser = await txn.query(
        'SELECT COUNT(id) FROM t_users WHERE username = ? AND password = ?',
        [username, oldPassword],
      );

      if (responseUser.first.fields['COUNT(id)'] == 0) {
        throw UpdateException(
          message: 'Failed to change password, username or password invalid',
        );
      }

      final updatePassword = await txn.query(
        'UPDATE t_users SET password = ? WHERE username = ?',
        [newPassword, username],
      );

      if (updatePassword.affectedRows == 0) {
        throw UpdateException(
          message: 'Failed to change password, please try again',
        );
      } else {
        return 'Successfully change password, please re-login';
      }
    });

    return response!;
  }

  @override
  Future<UserModel> login(String username, String password) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final responseUser = await txn.query(
        '''
        SELECT id, username, name, is_active
        FROM t_users
        WHERE username = ? AND password = ?
        ''',
        [username, password],
      );

      if (responseUser.firstOrNull == null) {
        throw NotFoundException(
          message: 'Username or password you entered is incorrect',
        );
      } else {
        final user = responseUser.first.fields;

        final responseModule = await txn.query(
          '''
          SELECT CONCAT(m.module_name, '_', p.permission_name) AS module
          FROM t_user_permission_module AS upm
          JOIN t_modules AS m ON upm.module_id = m.id
          JOIN t_permissions AS p ON upm.permission_id = p.id
          WHERE upm.user_id = ?
          ORDER BY upm.module_id
          ''',
          [user['id']],
        );

        final module = responseModule.map((e) => e['module']).toList();

        user.addEntries({'modules': module}.entries);

        return user;
      }
    });

    return UserModel.fromDatabase(response!);
  }
}
