// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase {
  LogoutUseCase(this._repository);

  final UserRepository _repository;

  Future<Either<Failure, void>> call() async {
    return _repository.logout();
  }
}
