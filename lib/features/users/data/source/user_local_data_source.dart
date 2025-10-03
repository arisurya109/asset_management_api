// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/users/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> createUser(UserModel params);
  Future<List<UserModel>> findAllUser();
  Future<UserModel> findByIdUser(int params);
  Future<UserModel> updateUser(UserModel params);

  Future<UserModel> login({
    required String username,
    required String password,
  });
  Future<void> logout();
}
