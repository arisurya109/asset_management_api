// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/users/data/model/user_model.dart';
import 'package:asset_management_api/features/users/data/source/user_local_data_source.dart';
import 'package:asset_management_api/features/users/domain/entities/user.dart';
import 'package:asset_management_api/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._source);

  final UserLocalDataSource _source;

  @override
  Future<Either<Failure, User>> createUser(User params) async {
    try {
      final response = await _source.createUser(UserModel.fromEntity(params));
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<User>>> findAllUser(int idRequest) async {
    try {
      final response = await _source.findAllUser(idRequest);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> findByIdUser(int params) async {
    try {
      final response = await _source.findByIdUser(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteUser(int params) async {
    try {
      final response = await _source.deleteUser(params);
      return Right(response);
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User params) async {
    try {
      final response = await _source.updateUser(UserModel.fromEntity(params));
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(
    String username,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final response = await _source.changePassword(
        username,
        oldPassword,
        newPassword,
      );
      return Right(response);
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      final response = await _source.login(username, password);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> autoLogin(int id) async {
    try {
      final response = await _source.autoLogin(id);
      return Right(response.toEntity());
    } catch (e) {
      print(e);
      return Left(CreateFailure(e.toString()));
    }
  }
}
