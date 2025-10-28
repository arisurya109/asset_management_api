// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_template_item.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePreparationTemplateItemUseCase {
  CreatePreparationTemplateItemUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, List<PreparationTemplateItem>>> call(
    List<PreparationTemplateItem> params,
    int templateId,
  ) async {
    return _repository.createPreparationTemplateItem(params, templateId);
  }
}
