// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/vendor/domain/entities/vendor.dart';
import 'package:asset_management_api/features/vendor/domain/repositories/vendor_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateVendorUseCase {
  UpdateVendorUseCase(this._repository);

  final VendorRepository _repository;

  Future<Either<Failure, Vendor>> call(Vendor params) async {
    return _repository.updateVendor(params);
  }
}
