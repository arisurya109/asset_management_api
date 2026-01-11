// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/assets/domain/entities/asset_detail_response.dart';
import 'package:dartz/dartz.dart';

class FindAssetDetailByIdUseCase {
  FindAssetDetailByIdUseCase(this._repository);

  final AssetsRepository _repository;

  Future<Either<Failure, AssetDetailResponse>> call(int params) async {
    return _repository.findAssetDetailById(params);
  }
}
