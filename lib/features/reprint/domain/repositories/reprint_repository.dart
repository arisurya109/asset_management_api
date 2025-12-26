// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ReprintRepository {
  Future<Either<Failure, Map<String, dynamic>>> reprintAsset(String params);
  Future<Either<Failure, Map<String, dynamic>>> reprintLocation(String params);
}
