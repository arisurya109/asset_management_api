// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_header.dart';
import 'package:asset_management_api/features/picking/domain/repositories/picking_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPickingTaskUseCase {
  FindAllPickingTaskUseCase(this._repository);

  final PickingRepository _repository;

  Future<Either<Failure, List<PickingHeader>>> call({
    required int userId,
  }) async {
    return _repository.findAllPickingTask(userId: userId);
  }
}
