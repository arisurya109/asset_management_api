// ignore_for_file: one_member_abstracts, public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/inventory/domain/entities/inventory.dart';
import 'package:dartz/dartz.dart';

abstract class InventoryRepository {
  Future<Either<Failure, Inventory>> findInventory(
    String params,
  );
}
