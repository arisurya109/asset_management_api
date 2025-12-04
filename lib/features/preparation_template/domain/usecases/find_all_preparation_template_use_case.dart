// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation_template/domain/entities/preparation_template.dart';
import 'package:asset_management_api/features/preparation_template/domain/repositories/preparation_template_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationTemplateUseCase {
  FindAllPreparationTemplateUseCase(this._repository);

  final PreparationTemplateRepository _repository;

  Future<Either<Failure, List<PreparationTemplate>>> call() async {
    return _repository.findAllPreparationTemplate();
  }
}
