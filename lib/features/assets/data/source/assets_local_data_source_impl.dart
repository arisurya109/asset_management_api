// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/helpers/asset.dart';
import 'package:asset_management_api/features/assets/data/model/assets_detail_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_request_model.dart';
import 'package:asset_management_api/features/assets/data/model/assets_response_model.dart';
import 'package:asset_management_api/features/assets/data/source/assets_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class AssetsLocalDataSourceImpl implements AssetsLocalDataSource {
  AssetsLocalDataSourceImpl(
    this._database,
    this._databaseErpOld,
  );

  final Database _database;
  final DatabaseErpOld _databaseErpOld;

  @override
  Future<List<AssetsResponseModel>> findAllAssets() async {
    try {
      final db = await _database.connection;

      final response = await db.query(
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
	      l1.name AS location,
	      a.purchase_order AS purchase_order,
	      a.remarks AS remarks
      FROM
      	t_assets AS a
      LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
      LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
      LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
      LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
      LEFT JOIN t_colors AS c ON a.color_id  = c.id
      LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
      WHERE a.quantity > 0
      ''',
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Assets is empty');
      }

      return response
          .map((e) => AssetsResponseModel.fromMap(e.fields))
          .toList();
    } on NotFoundException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<AssetsResponseModel> createAssets(AssetsRequestModel params) async {
    try {
      final db = await _database.connection;

      if (params.isMigration == 1) {
        final response = await _migrationAssets(params);

        return response;
      } else {
        final response = await db.transaction((txn) async {
          // Serial Number Not Null or Not Empty

          if (params.serialNumber!.isNotEmpty && params.uom == 1) {
            final checkSerialNumber = await txn.query(
              'SELECT COUNT(id) FROM t_assets WHERE serial_number = ?',
              [params.serialNumber],
            );

            if (checkSerialNumber.first.fields['COUNT(id)'] == 0) {
              final templateCode = AssetHelper.templateCode;

              final response = await txn.query(
                'SELECT COUNT(id) FROM t_assets WHERE DATE(registred_at) = CURDATE()',
              );

              const width = 4;

              final count = response.first.fields['COUNT(id)'] as int;
              final lastCode = (count + 1).toString().padLeft(width, '0');

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

              final categoryInit =
                  initTypeCategory.first.fields['category_init'];
              final typeInit = initTypeCategory.first.fields['type_init'];

              final assetCode =
                  '$typeInit-$categoryInit-$templateCode$lastCode';

              final registredAsset = await txn.query(
                '''
            INSERT INTO t_assets (
              asset_code, 
              serial_number, 
              status, 
              conditions, 
              remarks, 
              registred_by, 
              asset_model_id, 
              color_id, 
              purchase_order, 
              quantity, 
              location_id)
            VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
                [
                  assetCode,
                  params.serialNumber,
                  params.status,
                  params.conditions,
                  params.remarks,
                  params.registredBy,
                  params.assetModelId,
                  params.colorId,
                  params.purchaseOrder,
                  1,
                  params.locationId,
                ],
              );

              if (registredAsset.insertId == null ||
                  registredAsset.insertId == 0) {
                throw CreateException(message: 'Failed to create asset code');
              } else {
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
	              l1.name AS location,
	              a.purchase_order AS purchase_order,
	              a.remarks AS remarks
              FROM
              	t_assets AS a
              LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
              LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
              LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
              LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
              LEFT JOIN t_colors AS c ON a.color_id  = c.id
              LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
                WHERE a.id = ?
            ''',
                  [registredAsset.insertId],
                );
                return newAsset.first.fields;
              }
            } else {
              throw CreateException(
                message:
                    'Failed to create asset, serial number already to exists',
              );
            }
          } else if (params.uom == 1) {
            final templateCode = AssetHelper.templateCode;

            final response = await txn.query(
              'SELECT COUNT(id) FROM t_assets WHERE DATE(registred_at) = CURDATE()',
            );
            const width = 4;

            final count = response.first.fields['COUNT(id)'] as int;
            final lastCode = (count + 1).toString().padLeft(width, '0');

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

            final categoryInit = initTypeCategory.first.fields['category_init'];
            final typeInit = initTypeCategory.first.fields['type_init'];

            final assetCode = '$typeInit-$categoryInit-$templateCode$lastCode';

            final registredAsset = await txn.query(
              '''
            INSERT INTO t_assets (
              asset_code,
              serial_number,
              status, 
              conditions, 
              remarks, 
              registred_by, 
              asset_model_id, 
              color_id, 
              purchase_order, 
              quantity, 
              location_id)
            VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
              [
                assetCode,
                params.serialNumber,
                params.status,
                params.conditions,
                params.remarks,
                params.registredBy,
                params.assetModelId,
                params.colorId,
                params.purchaseOrder,
                1,
                params.locationId,
              ],
            );

            if (registredAsset.insertId == null ||
                registredAsset.insertId == 0) {
              throw CreateException(message: 'Failed to create asset code');
            } else {
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
	            l1.name AS location,
	            a.purchase_order AS purchase_order,
	            a.remarks AS remarks
            FROM
              t_assets AS a
            LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
            LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
            LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
            LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
            LEFT JOIN t_colors AS c ON a.color_id  = c.id
            LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
            WHERE a.id = ?
            ''',
                [registredAsset.insertId],
              );
              return newAsset.first.fields;
            }
          } else {
            // Asset Consumable
            final checkAssetLocation = await txn.query(
              'SELECT id FROM t_assets WHERE asset_model_id = ? AND location_id = ?',
              [params.assetModelId, params.locationId],
            );

            int idAsset;

            if (checkAssetLocation.firstOrNull == null) {
              // Insert
              final newAsset = await txn.query(
                '''
          INSERT INTO t_assets
            (asset_model_id, quantity, location_id, registred_by)
          VALUES
            (?, ?, ?, ?)
          ''',
                [
                  params.assetModelId,
                  params.quantity,
                  params.locationId,
                  params.registredBy,
                ],
              );
              idAsset = newAsset.insertId!;
            } else {
              // Update Quantity
              idAsset = checkAssetLocation.first.fields['id'] as int;
              final response = await txn.query(
                '''
          UPDATE t_assets
          SET quantity = quantity + ?
          WHERE id = ?
          ''',
                [params.quantity, idAsset],
              );

              if (response.affectedRows == 0) {
                throw CreateException(
                  message: 'Failed to update quantity asset',
                );
              }
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
	              l1.name AS location,
	              a.purchase_order AS purchase_order,
	              a.remarks AS remarks
              FROM
              	t_assets AS a
              LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
              LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
              LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
              LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
              LEFT JOIN t_colors AS c ON a.color_id  = c.id
              LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
                WHERE a.id = ?
            ''',
              [idAsset],
            );
            return newAsset.first.fields;
          }
        });
        return AssetsResponseModel.fromMap(response!);
      }
    } on NotFoundException {
      rethrow;
    } on CreateException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  Future<AssetsResponseModel> _migrationAssets(
    AssetsRequestModel params,
  ) async {
    try {
      final datasOld = await _getDatasAssetOld(params.assetIdOld!);

      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final checkSerialNumberAndAssetIdOld = await txn.query(
          'SELECT COUNT(id) FROM t_assets WHERE serial_number = ? AND asset_id_old = ?',
          [datasOld['serial_number'], datasOld['asset_id_old']],
        );

        if (checkSerialNumberAndAssetIdOld.first.fields['COUNT(id)'] as int >
            0) {
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
              purchase_order, 
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
            params.locationId,
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
	              l1.name AS location,
	              a.purchase_order AS purchase_order,
	              a.remarks AS remarks
              FROM
              	t_assets AS a
              LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
              LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
              LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
              LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
              LEFT JOIN t_colors AS c ON a.color_id  = c.id
              LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
              WHERE a.id = ?
            ''',
          [registredAsset.insertId],
        );

        return newAsset.first.fields;
      });

      return AssetsResponseModel.fromMap(response!);
    } on NotFoundException {
      rethrow;
    } on CreateException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> _getDatasAssetOld(String assetId) async {
    try {
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
    } on NotFoundException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<AssetsDetailModel>> findAssetDetailById(int params) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
      SELECT
        am.id AS id,
	      am.movement_type AS movement_type,
	      l1.name AS from_location,
	      l2.name AS to_location,
	      u.name AS movement_by,
	      am.movement_date,
	      am.references_number AS references_number,
	      am.notes AS notes
      FROM 
      	t_asset_movements AS am
      LEFT JOIN t_locations AS l1 ON am.from_location_id = l1.id
      LEFT JOIN t_locations AS l2 ON am.to_location_id  = l2.id
      LEFT JOIN t_users AS u ON am.movement_by = u.id
      WHERE am.asset_id = ?
      ''',
        [params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Assets no history movement');
      }

      return response
          .map((e) => AssetsDetailModel.fromDatabase(e.fields))
          .toList();
    } on NotFoundException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<AssetsResponseModel> createAssetTransfer({
    required int movementById,
    required int assetId,
    required String movementType,
    required int fromLocationId,
    required int toLocationId,
    int quantity = 1,
    String? notes,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final checkAssetAndLocation = await txn.query(
          '''
        SELECT id FROM t_assets WHERE id = ? AND location_id = ?
        ''',
          [assetId, fromLocationId],
        );

        int idAsset;

        if (checkAssetAndLocation.firstOrNull == null) {
          throw NotFoundException(
            message: 'Asset code or from location not valid in system',
          );
        }

        final checkToLocationType = await txn.query(
          '''
        SELECT id FROM t_locations
        WHERE id = ? AND (location_type = 'RACK' OR location_type = 'BOX')
        ''',
          [toLocationId],
        );

        if (checkToLocationType.firstOrNull == null) {
          throw NotFoundException(
            message: 'Failed to move asset, destination location not valid',
          );
        }

        idAsset = checkAssetAndLocation.first.fields['id'] as int;

        final newLocationAsset = await txn.query(
          '''
        UPDATE t_assets
        SET location_id = ?, updated_by = ?, updated_at = CURRENT_TIMESTAMP() 
        WHERE id = ?
        ''',
          [toLocationId, movementById, idAsset],
        );

        if (newLocationAsset.affectedRows == null ||
            newLocationAsset.affectedRows == 0) {
          throw CreateException(
            message: 'Failed, transfer asset to $toLocationId',
          );
        } else {
          final movementAsset = await txn.query('''
          INSERT INTO t_asset_movements 
            (asset_id, movement_type, from_location_id, to_location_id, movement_by, quantity)
          VALUES
            (?, ?, ?, ?, ?, ?)
          ''', [
            idAsset,
            movementType,
            fromLocationId,
            toLocationId,
            movementById,
            quantity,
          ]);

          if (movementAsset.insertId == null || movementAsset.insertId == 0) {
            txn.rollback();
          } else {
            final response = await txn.query(
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
	            l1.name AS location,
	            a.purchase_order AS purchase_order,
	            a.remarks AS remarks
            FROM
            	t_assets AS a
            LEFT JOIN t_asset_models AS am ON a.asset_model_id  = am.id
            LEFT JOIN t_asset_brands AS ab ON am.brand_id  = ab.id
            LEFT JOIN t_asset_categories AS ac ON am.category_id = ac.id
            LEFT JOIN t_asset_types AS ats ON am.type_id = ats.id
            LEFT JOIN t_colors AS c ON a.color_id  = c.id
            LEFT JOIN t_locations AS l1 ON a.location_id  = l1.id
            WHERE a.id = ?
            ''',
              [assetId],
            );
            return response.first.fields;
          }
        }
      });

      return AssetsResponseModel.fromMap(response!);
    } on NotFoundException {
      rethrow;
    } on CreateException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }
}
