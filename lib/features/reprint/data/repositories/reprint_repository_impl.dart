// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/reprint/data/source/reprint_local_data_source.dart';
import 'package:asset_management_api/features/reprint/domain/repositories/reprint_repository.dart';
import 'package:dartz/dartz.dart';

class ReprintRepositoryImpl implements ReprintRepository {
  ReprintRepositoryImpl(this._source);

  final ReprintLocalDataSource _source;

  @override
  Future<Either<Failure, Map<String, dynamic>>> reprintAsset(
    String params,
  ) async {
    try {
      final response = await _source.reprintAsset(params);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> reprintLocation(
    String params,
  ) async {
    try {
      final response = await _source.reprintLocation(params);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
