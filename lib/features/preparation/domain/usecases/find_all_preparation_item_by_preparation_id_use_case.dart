// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_item.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationItemByPreparationId {
  FindAllPreparationItemByPreparationId(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, List<PreparationItem>>> call(int params) async {
    return _repository.findAllPreparationItemByPreparationId(params);
  }
}
