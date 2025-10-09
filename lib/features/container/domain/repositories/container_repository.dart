// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/container/domain/entities/container.dart';
import 'package:dartz/dartz.dart';

abstract class ContainerRepository {
  Future<Either<Failure, Container>> createContainer(Container params);
  Future<Either<Failure, Container>> updateContainer(Container params);
  Future<Either<Failure, List<Container>>> findAllContainer();
}
