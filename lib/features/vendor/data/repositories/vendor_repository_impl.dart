// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/vendor/data/model/vendor_model.dart';
import 'package:asset_management_api/features/vendor/data/source/vendor_local_data_source.dart';
import 'package:asset_management_api/features/vendor/domain/entities/vendor.dart';
import 'package:asset_management_api/features/vendor/domain/repositories/vendor_repository.dart';
import 'package:dartz/dartz.dart';

class VendorRepositoryImpl implements VendorRepository {
  VendorRepositoryImpl(this._source);

  final VendorLocalDataSource _source;

  @override
  Future<Either<Failure, Vendor>> createVendor(Vendor params) async {
    try {
      final response = await _source.createVendor(
        VendorModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Vendor>>> findAllVendor() async {
    try {
      final response = await _source.findAllVendor();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Vendor>> updateVendor(Vendor params) async {
    try {
      final response = await _source.updateVendor(
        VendorModel.fromEntity(
          params,
        ),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
