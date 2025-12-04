// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_template/domain/entities/preparation_template_item.dart';
import 'package:asset_management_api/features/preparation_template/domain/repositories/preparation_template_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePreparationTemplateItemUseCase {
  CreatePreparationTemplateItemUseCase(this._repository);

  final PreparationTemplateRepository _repository;

  Future<Either<Failure, List<PreparationTemplateItem>>> call(
    List<PreparationTemplateItem> params,
    int templateId,
  ) async {
    return _repository.createPreparationTemplateItem(
      params: params,
      templateId: templateId,
    );
  }
}
