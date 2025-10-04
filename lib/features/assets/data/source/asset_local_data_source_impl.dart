// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/assets/data/model/asset_model.dart';
import 'package:asset_management_api/features/assets/data/source/asset_local_data_source.dart';

class AssetLocalDataSourceImpl implements AssetLocalDataSource {
  AssetLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<AssetModel> createAsset(AssetModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final result = await txn.query(
        'SELECT asset_code FROM t_assets ORDER BY id DESC LIMIT 1',
      );

      String assetCode;

      if (result.isEmpty) {
        assetCode = 'D0001';
      } else {
        final lastCode = result.first['asset_code'] as String;
        final lastNumber = int.parse(lastCode.substring(1));
        final nextNumber = lastNumber + 1;

        assetCode = 'D${nextNumber.toString().padLeft(4, '0')}';
      }

      final checkAsset = await txn.query(
        '''
        SELECT COUNT(id)
        FROM t_assets
        WHERE UPPER(asset_name) = UPPER(?)
        ''',
        [params.assetName],
      );

      if (checkAsset.first.fields['COUNT(id)'] as int > 0) {
        throw CreateException(
          message: 'Failed to add asset, asset name already to exists',
        );
      } else {
        final addNewAsset = await txn.query(
          '''
          INSERT INTO t_assets (asset_code, asset_name, asset_init)
          VALUES (?, ?, ?)
          ''',
          [
            assetCode,
            params.assetName!.toUpperCase(),
            params.assetInit!.toUpperCase(),
          ],
        );

        if (addNewAsset.insertId == 0 || addNewAsset.insertId == null) {
          throw CreateException(
            message: 'Failed to add asset, please try again',
          );
        }

        final assetNew = await txn.query(
          'SELECT * FROM t_assets WHERE id = ?',
          [addNewAsset.insertId],
        );

        return assetNew.first.fields;
      }
    });

    return AssetModel.fromMap(response!);
  }

  @override
  Future<List<AssetModel>> findAllAsset() async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_assets ORDER BY id ASC',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(
        message: 'Not assets yet, please add first asset',
      );
    }

    return response.map((e) => AssetModel.fromMap(e.fields)).toList();
  }

  @override
  Future<AssetModel> updateAsset(AssetModel params) async {
    final db = await _database.connection;

    final response = await db.transaction((txn) async {
      final response = await txn.query(
        'SELECT COUNT(id) FROM t_assets WHERE id = ?',
        [params.id],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(
          message: 'Failed to update asset, asset not found',
        );
      }

      final updateAsset = await txn.query(
        'UPDATE t_assets SET asset_name = ? WHERE id = ?',
        [params.assetName?.toUpperCase(), params.id],
      );

      if (updateAsset.affectedRows == 0 || updateAsset.affectedRows == null) {
        throw UpdateException(
          message: 'Failed to update asset, please try again',
        );
      }

      final newAsset = await txn.query(
        'SELECT * FROM t_assets WHERE id = ?',
        [params.id],
      );

      return newAsset.first.fields;
    });

    return AssetModel.fromMap(response!);
  }

  @override
  Future<AssetModel> findAssetById(int id) async {
    final db = await _database.connection;

    final response = await db.query(
      'SELECT * FROM t_assets WHERE id = ?',
      [id],
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(message: 'Failed to get asset, not found asset');
    }

    return AssetModel.fromMap(response.first.fields);
  }
}
