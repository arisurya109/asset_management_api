// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/vendor/domain/entities/vendor.dart';
import 'package:dartz/dartz.dart';

abstract class VendorRepository {
  Future<Either<Failure, Vendor>> createVendor(Vendor params);
  Future<Either<Failure, Vendor>> updateVendor(Vendor params);
  Future<Either<Failure, List<Vendor>>> findAllVendor();
}
