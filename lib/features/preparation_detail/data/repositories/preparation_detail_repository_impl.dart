// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_detail/data/model/preparation_detail_model.dart';
import 'package:asset_management_api/features/preparation_detail/data/source/preparation_detail_local_data_source.dart';
import 'package:asset_management_api/features/preparation_detail/domain/entities/preparation_detail.dart';
import 'package:asset_management_api/features/preparation_detail/domain/repositories/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class PreparationDetailRepositoryImpl implements PreparationDetailRepository {
  PreparationDetailRepositoryImpl(this._source);

  final PreparationDetailLocalDataSource _source;

  @override
  Future<Either<Failure, PreparationDetail>> createPreparationDetail({
    required PreparationDetail params,
  }) async {
    try {
      final response = await _source.createPreparationDetail(
        params: PreparationDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationDetail>>>
      findAllPreparationDetailByPreparationId({
    required int preparationId,
  }) async {
    try {
      final response = await _source.findAllPreparationDetailByPreparationId(
        preparationId: preparationId,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> findPreparationDetailById({
    required int id,
  }) async {
    try {
      final response = await _source.findPreparationDetailById(
        id: id,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> updatePreparationDetail({
    required PreparationDetail params,
  }) async {
    try {
      final response = await _source.updatePreparationDetail(
        params: PreparationDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>>
      updateStatusCompletedPreparationDetail({
    required int id,
    required int userId,
  }) async {
    try {
      final response = await _source.updateStatusCompletedPreparationDetail(
        id: id,
        userId: userId,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>>
      updateStatusProgressPreparationDetail({
    required int id,
    required int userId,
  }) async {
    try {
      final response = await _source.updateStatusProgressPreparationDetail(
        id: id,
        userId: userId,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
