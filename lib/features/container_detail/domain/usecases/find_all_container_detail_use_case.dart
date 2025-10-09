// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/container_detail/domain/entities/container_detail.dart';
import 'package:asset_management_api/features/container_detail/domain/repositories/container_detail_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllContainerDetailUseCase {
  FindAllContainerDetailUseCase(this._repository);

  final ContainerDetailRepository _repository;

  Future<Either<Failure, List<ContainerDetail>>> call() async {
    return _repository.findAllContainer();
  }
}
