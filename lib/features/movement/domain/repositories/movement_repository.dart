// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/movement/domain/entities/movement.dart';
import 'package:dartz/dartz.dart';

abstract class MovementRepository {
  Future<Either<Failure, String>> createMovement({
    required Movement params,
    required int userId,
  });
}
