// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/asset_transfer/data/model/asset_transfer_model.dart';
import 'package:asset_management_api/features/asset_transfer/data/source/asset_transfer_local_data_source.dart';

class AssetTransferLocalDataSourceImpl implements AssetTransferLocalDataSource {
  AssetTransferLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<AssetTransferModel> createAssetTransfer(
    AssetTransferModel params,
  ) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final checkAssetAndLocation = await txn.query(
        '''
        SELECT id FROM t_assets WHERE asset_code = ? AND location_id = ?
        ''',
        [params.assetCode, params.fromLocationId],
      );

      int idAsset;

      if (checkAssetAndLocation.firstOrNull == null) {
        throw CreateException(
          message: 'Asset code or from location not valid in system',
        );
      }

      final checkToLocationType = await txn.query(
        '''
        SELECT id FROM t_locations
        WHERE id = ? AND (location_type = 'RACK' OR location_type = 'BOX')
        ''',
        [params.toLocationId],
      );

      if (checkToLocationType.firstOrNull == null) {
        throw CreateException(
          message: 'Failed to move asset, destination location not valid',
        );
      }

      idAsset = checkAssetAndLocation.first.fields['id'] as int;

      final newLocationAsset = await txn.query(
        '''
        UPDATE t_assets
        SET location_id = ?, updated_by = ?, updated_at = CURRENT_TIMESTAMP()
        WHERE asset_code = ?
        ''',
        [params.toLocationId, params.movementById, params.assetCode],
      );

      if (newLocationAsset.affectedRows == null ||
          newLocationAsset.affectedRows == 0) {
        throw CreateException(
          message: 'Failed, transfer asset to ${params.toLocation}',
        );
      } else {
        final movementAsset = await txn.query('''
          INSERT INTO t_asset_movements 
            (asset_id, movement_type, from_location_id, to_location_id, movement_by, quantity)
          VALUES
            (?, ?, ?, ?, ?, ?)
          ''', [
          idAsset,
          params.movementType,
          params.fromLocationId,
          params.toLocationId,
          params.movementById,
          params.quantity,
        ]);

        if (movementAsset.insertId == null || movementAsset.insertId == 0) {
          txn.rollback();
        } else {
          final response = await txn.query(
            '''
            SELECT 
              am.id AS id,
              am.asset_id AS asset_id,
              ass.asset_code AS asset_code,
              am.quantity AS quantity,
              l.id AS from_location_id,
              l.name AS from_location,
              t.id AS to_location_id,
              t.name AS to_location,
              u.id AS movement_by_id,
              u.name AS movement_by
            FROM t_asset_movements AS am
            LEFT JOIN t_assets AS ass ON am.asset_id = ass.id
            LEFT JOIN t_locations AS l ON am.from_location_id = l.id
            LEFT JOIN t_locations AS t ON am.to_location_id = t.id
            LEFT JOIN t_users AS u ON am.movement_by = u.id
            WHERE am.id = ?
            ''',
            [movementAsset.insertId],
          );
          return response.first.fields;
        }
      }
    });

    return AssetTransferModel.fromDatabase(response!);
  }
}
