// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_response.dart';
import 'package:dartz/dartz.dart';

abstract class AssetsRepository {
  Future<Either<Failure, List<AssetsResponse>>> findAllAssets();
}
