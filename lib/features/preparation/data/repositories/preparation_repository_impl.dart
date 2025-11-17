// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_detail_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_item_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_template_item_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_template_model.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_item.dart';
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
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
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
    } on DatabaseException catch (e) {
      return Left(CreateFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deletePreparationTemplate(int params) async {
    try {
      final response = await _source.deletePreparationTemplate(params);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DeleteFailure(e.message));
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
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
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
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> createPreparation(
    Preparation params,
  ) async {
    try {
      final response = await _source.createPreparation(
        PreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Preparation>>> findAllPreparation() async {
    try {
      final response = await _source.findAllPreparation();
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> findPreparationById(int params) async {
    try {
      final response = await _source.findPreparationById(params);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updatePreparation(
    Preparation params,
  ) async {
    try {
      final response = await _source.updatePreparation(
        PreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> createPreparationDetail(
    PreparationDetail params,
  ) async {
    try {
      final response = await _source.createPreparationDetail(
        PreparationDetailModel.fromEntity(params),
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
      findAllPreparationDetailByPreparationId(int params) async {
    try {
      final response = await _source.findAllPreparationDetailByPreparationId(
        params,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> findPreparationDetailById(
    int params,
    int preparationid,
  ) async {
    try {
      final response = await _source.findPreparationDetailById(
        params,
        preparationid,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> updatePreparationDetail(
    PreparationDetail params,
  ) async {
    try {
      final response = await _source.updatePreparationDetail(
        PreparationDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationItem>> createPreparationItem(
    PreparationItem params,
  ) async {
    try {
      final response = await _source.createPreparationItem(
        PreparationItemModel.fromEntity(params),
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
  Future<Either<Failure, List<PreparationItem>>>
      findAllPreparationItemByPreparationDetailId(
    int params,
  ) async {
    try {
      final response =
          await _source.findAllPreparationItemByPreparationDetailId(
        params,
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
      findAllPreparationItemByPreparationId(
    int params,
  ) async {
    try {
      final response = await _source.findAllPreparationItemByPreparationId(
        params,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> completePreparationPicking(
    Preparation params,
  ) {
    // TODO: implement completePreparationPicking
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Preparation>> dispatchPreparation(
    Preparation params,
  ) async {
    try {
      final response = await _source.dispatchPreparation(
        PreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> completedPreparation(
    Preparation params,
    List<int> fileBytes,
    String originalName,
  ) async {
    try {
      final response = await _source.completedPreparation(
        PreparationModel.fromEntity(params),
        fileBytes,
        originalName,
      );
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, File>> findDocumentPreparationById(int params) async {
    try {
      final response = await _source.findDocumentPreparationById(params);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
