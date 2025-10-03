// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/users/domain/entities/user.dart';
import 'package:asset_management_api/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class CreateUserUseCase {
  CreateUserUseCase(this._repository);

  final UserRepository _repository;

  Future<Either<Failure, User>> call(User params) async {
    return _repository.createUser(params);
  }
}
