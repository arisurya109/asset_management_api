// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_template/data/model/preparation_template_item_model.dart';
import 'package:asset_management_api/features/preparation_template/data/model/preparation_template_model.dart';
import 'package:asset_management_api/features/preparation_template/data/source/preparation_template_local_data_source.dart';
import 'package:asset_management_api/features/preparation_template/domain/entities/preparation_template.dart';
import 'package:asset_management_api/features/preparation_template/domain/entities/preparation_template_item.dart';
import 'package:asset_management_api/features/preparation_template/domain/repositories/preparation_template_repository.dart';
import 'package:dartz/dartz.dart';

class PreparationTemplateRepositoryImpl
    implements PreparationTemplateRepository {
  PreparationTemplateRepositoryImpl(this._source);

  final PreparationTemplateLocalDataSource _source;

  @override
  Future<Either<Failure, PreparationTemplate>> createPreparationTemplate({
    required PreparationTemplate params,
  }) async {
    try {
      final response = await _source.createPreparationTemplate(
        params: PreparationTemplateModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationTemplateItem>>>
      createPreparationTemplateItem({
    required List<PreparationTemplateItem> params,
    required int templateId,
  }) async {
    try {
      final response = await _source.createPreparationTemplateItem(
        params: params.map(PreparationTemplateItemModel.fromEntity).toList(),
        templateId: templateId,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationTemplate>>>
      findAllPreparationTemplate() async {
    try {
      final response = await _source.findAllPreparationTemplate();
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationTemplateItem>>>
      findAllPreparationTemplateItemByTemplateId({required int params}) async {
    try {
      final response = await _source.findAllPreparationTemplateItemByTemplateId(
        params: params,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
