// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/users/data/model/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> createUser(UserModel params);
  Future<UserModel> updateUser(UserModel params);
  Future<List<UserModel>> findAllUser(int idRequest);
  Future<UserModel> findByIdUser(int params);
  Future<String> deleteUser(int params);

  Future<UserModel> login(String username, String password);
  Future<String> changePassword(
    String username,
    String oldPassword,
    String newPassword,
  );
  Future<UserModel> autoLogin(int id);
}
