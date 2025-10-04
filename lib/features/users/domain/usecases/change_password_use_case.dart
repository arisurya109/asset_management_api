// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUseCase {
  ChangePasswordUseCase(this._repository);

  final UserRepository _repository;

  Future<Either<Failure, String>> call(
    String username,
    String oldPassword,
    String newPassword,
  ) async {
    return _repository.changePassword(username, oldPassword, newPassword);
  }
}
