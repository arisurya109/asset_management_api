// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/inventory/data/source/inventory_local_data_source.dart';
import 'package:asset_management_api/features/inventory/domain/entities/inventory.dart';
import 'package:asset_management_api/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:dartz/dartz.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  InventoryRepositoryImpl(this._source);

  final InventoryLocalDataSource _source;

  @override
  Future<Either<Failure, Inventory>> findInventory(String params) async {
    try {
      final response = await _source.findInventory(params);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
