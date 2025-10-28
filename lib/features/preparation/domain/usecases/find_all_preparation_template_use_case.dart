// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_template.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationTemplateUseCase {
  FindAllPreparationTemplateUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, List<PreparationTemplate>>> call() async {
    return _repository.findAllPreparationTemplate();
  }
}
