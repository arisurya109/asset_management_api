// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/container/domain/entities/container.dart';
import 'package:asset_management_api/features/container/domain/repositories/container_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllContainerUseCase {
  FindAllContainerUseCase(this._repository);

  final ContainerRepository _repository;

  Future<Either<Failure, List<Container>>> call() async {
    return _repository.findAllContainer();
  }
}
