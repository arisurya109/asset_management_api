// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class GetPreparationTypesUseCase {
  GetPreparationTypesUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, List<String>>> call() async {
    return _repository.getPreparationTypes();
  }
}
