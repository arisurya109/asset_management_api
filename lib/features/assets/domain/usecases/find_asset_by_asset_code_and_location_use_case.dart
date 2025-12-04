// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:dartz/dartz.dart';

class FindAssetByAssetCodeAndLocationUseCase {
  FindAssetByAssetCodeAndLocationUseCase(this._repository);

  final AssetsRepository _repository;

  Future<Either<Failure, AssetsResponse>> call({
    required String assetCode,
    required String location,
  }) async {
    return _repository.findAssetByAssetCodeAndLocation(
      assetCode: assetCode,
      location: location,
    );
  }
}
