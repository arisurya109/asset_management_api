// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_item/data/model/preparation_item_model.dart';
import 'package:asset_management_api/features/preparation_item/data/source/preparation_item_local_data_source.dart';
import 'package:asset_management_api/features/preparation_item/domain/entities/preparation_item.dart';
import 'package:asset_management_api/features/preparation_item/domain/repositories/preparation_item_repository.dart';
import 'package:dartz/dartz.dart';

class PreparationItemRepositoryImpl implements PreparationItemRepository {
  PreparationItemRepositoryImpl(this._source);

  final PreparationItemLocalDataSource _source;

  @override
  Future<Either<Failure, PreparationItem>> createPreparationItem({
    required PreparationItem params,
  }) async {
    try {
      final response = await _source.createPreparationItem(
        params: PreparationItemModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deletePreparationItem({
    required int id,
  }) async {
    try {
      final response = await _source.deletePreparationItem(
        id: id,
      );
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DeleteFailure(e.message));
    } on DeleteException catch (e) {
      return Left(DeleteFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationItem>>>
      findAllPreparationItemByPreparationDetailId({
    required int preparationDetailId,
  }) async {
    try {
      final response =
          await _source.findAllPreparationItemByPreparationDetailId(
        preparationDetailId: preparationDetailId,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationItem>>>
      findAllPreparationItemByPreparationId({
    required int preparationId,
  }) async {
    try {
      final response = await _source.findAllPreparationItemByPreparationId(
        preparationId: preparationId,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
