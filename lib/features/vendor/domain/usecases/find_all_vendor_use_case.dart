// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/vendor/domain/entities/vendor.dart';
import 'package:asset_management_api/features/vendor/domain/repositories/vendor_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllVendorUseCase {
  FindAllVendorUseCase(this._repository);

  final VendorRepository _repository;

  Future<Either<Failure, List<Vendor>>> call() async {
    return _repository.findAllVendor();
  }
}
