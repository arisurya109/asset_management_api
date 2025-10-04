// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/brands/domain/entities/brand.dart';
import 'package:dartz/dartz.dart';

abstract class BrandRepository {
  Future<Either<Failure, Brand>> createBrand(Brand params);
  Future<Either<Failure, List<Brand>>> findAllBrand();
  Future<Either<Failure, List<Brand>>> findBrandByIdAsset(int params);
  Future<Either<Failure, Brand>> findBrandById(int params);
  Future<Either<Failure, Brand>> updateBrand(Brand params);
}
