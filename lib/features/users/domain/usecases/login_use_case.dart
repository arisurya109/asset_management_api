import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/users/domain/entities/user.dart';
import 'package:asset_management_api/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  LoginUseCase(this._repository);

  final UserRepository _repository;

  Future<Either<Failure, User>> call({
    required String username,
    required String password,
  }) async {
    return _repository.login(
      username: username,
      password: password,
    );
  }
}
