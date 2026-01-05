// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/movement/data/model/movement_model.dart';
import 'package:asset_management_api/features/movement/data/source/movement_local_data_source.dart';
import 'package:asset_management_api/features/movement/domain/entities/movement.dart';
import 'package:asset_management_api/features/movement/domain/repositories/movement_repository.dart';
import 'package:dartz/dartz.dart';

class MovementRepositoryImpl implements MovementRepository {
  MovementRepositoryImpl(this._source);

  final MovementLocalDataSource _source;

  @override
  Future<Either<Failure, String>> createMovement({
    required Movement params,
    required int userId,
  }) async {
    try {
      final response = await _source.createMovement(
        params: MovementModel.fromEntity(params),
        userId: userId,
      );
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
