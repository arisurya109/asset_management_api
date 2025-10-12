import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/users/user_export.dart';
import 'package:dartz/dartz.dart';

class AutoLoginUseCase {
  AutoLoginUseCase(this._repository);

  final UserRepository _repository;

  Future<Either<Failure, User>> call(int id) async {
    return _repository.autoLogin(id);
  }
}
