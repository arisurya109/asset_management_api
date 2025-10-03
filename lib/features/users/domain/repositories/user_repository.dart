// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/users/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> createUser(User params);
  Future<Either<Failure, List<User>>> findAllUser();
  Future<Either<Failure, User>> findByIdUser(int params);
  Future<Either<Failure, User>> updateUser(User params);

  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  });
  Future<Either<Failure, void>> logout();
}
