// // ignore_for_file: public_member_api_docs

// import 'package:asset_management_api/core/config/database.dart';
// import 'package:asset_management_api/core/error/exception.dart';
// import 'package:asset_management_api/features/asset_migration/data/model/asset_migration_model.dart';
// import 'package:asset_management_api/features/asset_migration/data/source/asset_migration_local_data_source.dart';

// class AssetMigrationLocalDataSourceImpl
//     implements AssetMigrationLocalDataSource {
//   AssetMigrationLocalDataSourceImpl(this._database, this._databaseErpOld);

//   final Database _database;
//   final DatabaseErpOld _databaseErpOld;
//   @override
//   Future<AssetMigrationModel> createNewAsset(
//     AssetMigrationModel params,
//   ) async {
//     final db = await _database.connection;

//     final response = await db.transaction((txn) async {
//       final checkModel = await txn.query(
//         'SELECT is_consumable, unit, has_serial FROM t_asset_models WHERE id = ?',
//         [params.assetModelId],
//       );

//       if (checkModel.firstOrNull == null) {
//         throw CreateException(message: 'Asset model is empty');
//       }
//       final isCons = checkModel.first['is_consumable'] as int;
//       final unit = checkModel.first['unit'] as int;
//       final hasSerial = checkModel.first['has_serial'] as int;

//       // Kabel Etc
//       if (isCons == 1) {
//         final checkAssetExists = await txn.query(
//           'SELECT COUNT(id) FROM t_assets WHERE id = ?',
//           [params.assetModelId],
//         );

//         if (checkAssetExists.first.fields['COUNT(id)'] == 0) {
//           // Create New Asset
//           final newAsset = await txn.query(
//             '''
//             INSERT INTO t_assets
//               ()
//             ''',
//           );
//         } else {
//           // Update Pcs Asset
//         }
//       }
//     });
//   }

//   @override
//   Future<List<AssetMigrationModel>> findAllAsset() {
//     // TODO: implement findAllAsset
//     throw UnimplementedError();
//   }

//   @override
//   Future<AssetMigrationModel> isMigrationAsset(AssetMigrationModel params) {
//     // TODO: implement isMigrationAsset
//     throw UnimplementedError();
//   }
// }
