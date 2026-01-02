// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/inventory/domain/entities/inventory.dart';
import 'package:asset_management_api/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:dartz/dartz.dart';

class FindInventoryUseCase {
  FindInventoryUseCase(this._repository);

  final InventoryRepository _repository;

  Future<Either<Failure, Inventory>> call(String params) async {
    return _repository.findInventory(params);
  }
}
