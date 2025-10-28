// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
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
}
