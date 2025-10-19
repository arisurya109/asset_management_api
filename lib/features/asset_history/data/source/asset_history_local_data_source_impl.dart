// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/asset_history/data/model/asset_history_model.dart';
import 'package:asset_management_api/features/asset_history/data/source/asset_history_local_data_source.dart';

class AssetHistoryLocalDataSourceImpl implements AssetHistoryLocalDataSource {
  AssetHistoryLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<List<AssetHistoryModel>> findAllAssetHistoryById(int params) async {
    final db = await _database.connection;

    final response = await db.query(
      '''
      SELECT
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
        .map((e) => AssetHistoryModel.fromDatabase(e.fields))
        .toList();
  }
}
