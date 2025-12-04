// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_template/domain/entities/preparation_template.dart';
import 'package:asset_management_api/features/preparation_template/domain/entities/preparation_template_item.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationTemplateRepository {
  // Preparation Template
  Future<Either<Failure, PreparationTemplate>> createPreparationTemplate({
    required PreparationTemplate params,
  });

  Future<Either<Failure, List<PreparationTemplate>>>
      findAllPreparationTemplate();

  // Preparation Template Item
  Future<Either<Failure, List<PreparationTemplateItem>>>
      createPreparationTemplateItem({
    required List<PreparationTemplateItem> params,
    required int templateId,
  });

  Future<Either<Failure, List<PreparationTemplateItem>>>
      findAllPreparationTemplateItemByTemplateId({
    required int params,
  });
}
