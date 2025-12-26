// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/reprint/domain/repositories/reprint_repository.dart';
import 'package:dartz/dartz.dart';

class ReprintLocationUseCase {
  ReprintLocationUseCase(this._repository);

  final ReprintRepository _repository;

  Future<Either<Failure, Map<String, dynamic>>> call(String params) async {
    return _repository.reprintLocation(params);
  }
}
