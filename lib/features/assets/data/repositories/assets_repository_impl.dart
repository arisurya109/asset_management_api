// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/data/model/assets_request_model.dart';
import 'package:asset_management_api/features/assets/data/source/assets_local_data_source.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_request.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_response.dart';
import 'package:asset_management_api/features/assets/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class AssetsRepositoryImpl implements AssetsRepository {
  AssetsRepositoryImpl(this._source);

  final AssetsLocalDataSource _source;

  @override
  Future<Either<Failure, List<AssetsResponse>>> findAllAssets() async {
    try {
      final response = await _source.findAllAssets();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetsResponse>> createAssets(
    AssetsRequest params,
  ) async {
    try {
      final response = await _source.createAssets(
        AssetsRequestModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
