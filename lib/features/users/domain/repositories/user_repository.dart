// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/users/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> createUser(User params);
  Future<Either<Failure, User>> updateUser(User params);
  Future<Either<Failure, User>> findByIdUser(int params);
  Future<Either<Failure, List<User>>> findAllUser(int idRequest);
  Future<Either<Failure, User>> updateStatusUser(int id, int params);

  Future<Either<Failure, User>> login(String username, String password);
  Future<Either<Failure, String>> changePassword(
    String username,
    String oldPassword,
    String newPassword,
  );
  Future<Either<Failure, User>> autoLogin(int id);
}
