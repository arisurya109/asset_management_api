// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/container/data/model/container_model.dart';
import 'package:asset_management_api/features/container/data/source/container_local_data_source.dart';
import 'package:asset_management_api/features/container/domain/entities/container.dart';
import 'package:asset_management_api/features/container/domain/repositories/container_repository.dart';
import 'package:dartz/dartz.dart';

class ContainerRepositoryImpl implements ContainerRepository {
  ContainerRepositoryImpl(this._source);

  final ContainerLocalDataSource _source;

  @override
  Future<Either<Failure, Container>> createContainer(Container params) async {
    try {
      final response = await _source.createContainer(
        ContainerModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Container>>> findAllContainer() async {
    try {
      final response = await _source.findAllContainer();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Container>> updateContainer(Container params) async {
    try {
      final response = await _source.updateContainer(
        ContainerModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
