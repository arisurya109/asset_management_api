// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_item.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_template.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_template_item.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationRepository {
  // Preparation Template
  Future<Either<Failure, PreparationTemplate>> createPreparationTemplate(
    PreparationTemplate params,
  );

  Future<Either<Failure, List<PreparationTemplate>>>
      findAllPreparationTemplate();

  Future<Either<Failure, String>> deletePreparationTemplate(
    int params,
  );

  // Preparation Template Item
  Future<Either<Failure, List<PreparationTemplateItem>>>
      createPreparationTemplateItem(
    List<PreparationTemplateItem> params,
    int templateId,
  );

  Future<Either<Failure, List<PreparationTemplateItem>>>
      findAllPreparationTemplateItemByTemplateId(
    int params,
  );

  // Preparation
  Future<Either<Failure, List<Preparation>>> findAllPreparation();
  Future<Either<Failure, Preparation>> findPreparationById(int params);
  Future<Either<Failure, Preparation>> createPreparation(
    Preparation params,
  );
  Future<Either<Failure, Preparation>> updatePreparation(
    Preparation params,
  );
  Future<Either<Failure, Preparation>> completePreparationPicking(
    Preparation params,
  );
  Future<Either<Failure, Preparation>> dispatchPreparation(
    Preparation params,
  );
  Future<Either<Failure, Preparation>> completedPreparation(
    Preparation params,
    List<int> fileBytes,
    String originalName,
  );
  Future<Either<Failure, File>> findDocumentPreparationById(int params);

  // Preparation Detail
  Future<Either<Failure, List<PreparationDetail>>>
      findAllPreparationDetailByPreparationId(
    int params,
  );
  Future<Either<Failure, PreparationDetail>> createPreparationDetail(
    PreparationDetail params,
  );
  Future<Either<Failure, PreparationDetail>> updatePreparationDetail(
    PreparationDetail params,
  );
  Future<Either<Failure, PreparationDetail>> findPreparationDetailById(
    int params,
    int preparationId,
  );

  // Preparation Detail Item
  Future<Either<Failure, PreparationItem>> createPreparationItem(
    PreparationItem params,
  );
  Future<Either<Failure, List<PreparationItem>>>
      findAllPreparationItemByPreparationDetailId(
    int params,
  );
  Future<Either<Failure, List<PreparationItem>>>
      findAllPreparationItemByPreparationId(
    int params,
  );
}
