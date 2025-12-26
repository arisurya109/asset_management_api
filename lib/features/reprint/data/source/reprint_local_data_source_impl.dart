import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/reprint/data/source/reprint_local_data_source.dart';

class ReprintLocalDataSourceImpl implements ReprintLocalDataSource {
  ReprintLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<Map<String, dynamic>> reprintAsset(String params) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
        SELECT
          a.asset_code,
          a.serial_number,
          am.name AS asset_model
        FROM t_assets a
        LEFT JOIN t_asset_models am ON a.asset_model_id = am.id
        WHERE ? IN (a.asset_code, a.serial_number)
        LIMIT 1
        ''',
        [params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Asset not found');
      }

      return response.first.fields;
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> reprintLocation(String params) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
        SELECT
          name,
          location_type
        FROM t_locations
        WHERE name = ?
        LIMIT 1
        ''',
        [params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Location not found');
      }

      return response.first.fields;
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }
}
