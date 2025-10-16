// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_response.dart';
import 'package:asset_management_api/features/assets/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetsUseCase {
  FindAllAssetsUseCase(this._repository);

  final AssetsRepository _repository;

  Future<Either<Failure, List<AssetsResponse>>> call() async {
    return _repository.findAllAssets();
  }
}
