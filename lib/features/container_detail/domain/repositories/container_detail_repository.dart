// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/container_detail/domain/entities/container_detail.dart';
import 'package:dartz/dartz.dart';

abstract class ContainerDetailRepository {
  Future<Either<Failure, ContainerDetail>> createContainerDetail(
    ContainerDetail params,
  );
  Future<Either<Failure, ContainerDetail>> updateContainerDetail(
    ContainerDetail params,
  );
  Future<Either<Failure, List<ContainerDetail>>> findAllContainer();
}
