import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_template_item_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_template_model.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_template.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_template_item.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class PreparationRepositoryImpl implements PreparationRepository {
  PreparationRepositoryImpl(this._source);

  final PreparationLocalDataSource _source;

  @override
  Future<Either<Failure, PreparationTemplate>> createPreparationTemplate(
    PreparationTemplate params,
  ) async {
    try {
      final response = await _source.createPreparationTemplate(
        PreparationTemplateModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationTemplateItem>>>
      createPreparationTemplateItem(
          List<PreparationTemplateItem> params, int templateId) async {
    try {
      final response = await _source.createPreparationTemplateItem(
        params.map(PreparationTemplateItemModel.fromEntity).toList(),
        templateId,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deletePreparationTemplate(int params) async {
    try {
      final response = await _source.deletePreparationTemplate(params);
      return Right(response);
    } on DeleteException catch (e) {
      return Left(DeleteFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationTemplate>>>
      findAllPreparationTemplate() async {
    try {
      final response = await _source.findAllPreparationTemplate();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationTemplateItem>>>
      findAllPreparationTemplateItemByTemplateId(int params) async {
    try {
      final response = await _source.findAllPreparationTemplateItemByTemplateId(
        params,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
