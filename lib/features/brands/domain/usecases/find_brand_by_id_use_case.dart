// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/brands/domain/entities/brand.dart';
import 'package:asset_management_api/features/brands/domain/repositories/brand_repository.dart';
import 'package:dartz/dartz.dart';

class FindBrandByIdUseCase {
  FindBrandByIdUseCase(this._repository);

  final BrandRepository _repository;

  Future<Either<Failure, Brand>> call(int params) async {
    return _repository.findBrandById(params);
  }
}
