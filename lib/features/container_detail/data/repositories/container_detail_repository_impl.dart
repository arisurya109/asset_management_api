// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/container_detail/data/model/container_detail_model.dart';
import 'package:asset_management_api/features/container_detail/data/source/container_detail_local_data_source.dart';
import 'package:asset_management_api/features/container_detail/domain/entities/container_detail.dart';
import 'package:asset_management_api/features/container_detail/domain/repositories/container_detail_repository.dart';
import 'package:dartz/dartz.dart';

class ContainerDetailRepositoryImpl implements ContainerDetailRepository {
  ContainerDetailRepositoryImpl(this._source);

  final ContainerDetailLocalDataSource _source;

  @override
  Future<Either<Failure, ContainerDetail>> createContainerDetail(
    ContainerDetail params,
  ) async {
    try {
      final response = await _source.createContainerDetail(
        ContainerDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ContainerDetail>>> findAllContainer() async {
    try {
      final response = await _source.findAllContainerDetail();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ContainerDetail>> updateContainerDetail(
    ContainerDetail params,
  ) async {
    try {
      final response = await _source.updateContainerDetail(
        ContainerDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
