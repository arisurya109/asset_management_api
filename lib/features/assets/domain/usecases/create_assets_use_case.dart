// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_request.dart';
import 'package:dartz/dartz.dart';

class CreateAssetsUseCase {
  CreateAssetsUseCase(this._repository);

  final AssetsRepository _repository;

  Future<Either<Failure, AssetsResponse>> call(AssetsRequest params) async {
    return _repository.createAssets(params);
  }
}
