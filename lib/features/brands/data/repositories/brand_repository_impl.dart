// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/brands/data/model/brand_model.dart';
import 'package:asset_management_api/features/brands/data/source/brand_local_data_source.dart';
import 'package:asset_management_api/features/brands/domain/entities/brand.dart';
import 'package:asset_management_api/features/brands/domain/repositories/brand_repository.dart';
import 'package:dartz/dartz.dart';

class BrandRepositoryImpl implements BrandRepository {
  BrandRepositoryImpl(this._source);

  final BrandLocalDataSource _source;

  @override
  Future<Either<Failure, Brand>> createBrand(Brand params) async {
    try {
      final response = await _source.createBrand(BrandModel.fromEntity(params));
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Brand>>> findAllBrand() async {
    try {
      final response = await _source.findAllBrand();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Brand>> findBrandById(int params) async {
    try {
      final response = await _source.findBrandById(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Brand>>> findBrandByIdAsset(int params) async {
    try {
      final response = await _source.findBrandByIdAsset(params);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Brand>> updateBrand(Brand params) async {
    try {
      final response = await _source.updateBrand(BrandModel.fromEntity(params));
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
