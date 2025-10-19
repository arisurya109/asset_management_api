// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/helpers/asset.dart';
import 'package:asset_management_api/features/asset_migration/data/model/asset_migration_model.dart';
import 'package:asset_management_api/features/asset_migration/data/source/asset_migration_local_data_source.dart';

class AssetMigrationLocalDataSourceImpl
    implements AssetMigrationLocalDataSource {
  AssetMigrationLocalDataSourceImpl(this._database, this._databaseErpOld);

  final Database _database;
  final DatabaseErpOld _databaseErpOld;

  @override
  Future<AssetMigrationModel> migrationAsset(
    AssetMigrationModel params,
  ) async {
    try {
      final datasOld = await _getDatasAssetOld(params.assetIdOld!);

      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final checkSerialNumberAndAssetIdOld = await txn.query(
          'SELECT COUNT(id) FROM t_assets WHERE serial_number = ? AND asset_id_old = ?',
          [datasOld['serial_number'], datasOld['asset_id_old']],
        );

        if (checkSerialNumberAndAssetIdOld.firstOrNull != null) {
          throw CreateException(message: 'Asset already exists');
        }

        final initTypeCategory = await txn.query(
          '''
            SELECT 
              ac.init AS category_init,
              at.init AS type_init
            FROM t_asset_models AS am
            LEFT JOIN t_asset_categories AS ac ON am.category_id  = ac.id
            LEFT JOIN t_asset_types AS at ON am.type_id  = at.id
            WHERE am.id = ?
            ''',
          [params.assetModelId],
        );

        final templateCode = AssetHelper.templateCode;

        final response = await txn.query(
          'SELECT COUNT(id) FROM t_assets WHERE DATE(registred_at) = CURDATE()',
        );

        const width = 4;

        final count = response.first.fields['COUNT(id)'] as int;
        final lastCode = (count + 1).toString().padLeft(width, '0');

        final categoryInit = initTypeCategory.first.fields['category_init'];
        final typeInit = initTypeCategory.first.fields['type_init'];

        final assetCode = '$typeInit-$categoryInit-$templateCode$lastCode';

        final registredAsset = await txn.query(
          '''
            INSERT INTO t_assets (
              asset_code, 
              asset_id_old,
              serial_number,
              purchase_order_number, 
              status, 
              conditions, 
              remarks, 
              registred_by, 
              asset_model_id, 
              color_id, 
              quantity, 
              location_id)
            VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
          [
            assetCode,
            datasOld['asset_id_old'],
            datasOld['serial_number'],
            datasOld['purchase_order_number'],
            params.status,
            params.conditions,
            params.remarks,
            params.registredBy,
            params.assetModelId,
            params.colorId,
            1,
            params.locationDetailId,
          ],
        );

        if (registredAsset.insertId == null || registredAsset.insertId == 0) {
          throw CreateException(
            message: 'Failed to migrate asset, please try again',
          );
        }
        final newAsset = await txn.query(
          '''
              SELECT
	              a.id AS id,
	              a.serial_number AS serial_number,
	              a.asset_code AS asset_code,
	              a.status AS status,
	              a.conditions AS conditions,
	              a.quantity AS quantity,
	              am.unit AS uom,
	              am.name AS model,
	              ac.name AS category,
	              ab.name AS brand,
	              ats.name AS types,
	              c.name AS color,
	              l2.name AS location,
	              l1.name AS location_detail,
	              a.purchase_order_number AS purchase_order,
	              a.remarks AS remarks
            FROM
            	  t_assets AS a
            LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
            LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
            LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
            LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
            LEFT JOIN t_colors AS c ON a.color_id  = c.id
            LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
            LEFT JOIN t_locations AS l2 ON l1.parent_id  = l2.id
            WHERE a.id = ?
            ''',
          [registredAsset.insertId],
        );

        return newAsset.first.fields;
      });

      return AssetMigrationModel.fromMap(response!);
    } on NotFoundException catch (e) {
      throw NotFoundException(message: e.message);
    }
  }

  Future<Map<String, dynamic>> _getDatasAssetOld(String assetId) async {
    final dbOld = await _databaseErpOld.connection;

    final response = await dbOld.query(
      '''
      SELECT
	      sn AS serial_number,
	      asset_id AS asset_id_old,
	      po_no AS purchase_order_number
      FROM
        t_asset_id
      WHERE asset_id = ?
      ''',
      [assetId],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Failed to migrate, asset old is not found',
      );
    }

    return response.first.fields;
  }
}
