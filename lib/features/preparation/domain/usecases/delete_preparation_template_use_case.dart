// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePreparationTemplateUseCase {
  DeletePreparationTemplateUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, String>> call(int params) async {
    return _repository.deletePreparationTemplate(params);
  }
}
