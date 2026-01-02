import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/inventory/data/model/inventory_box_model.dart';
import 'package:asset_management_api/features/inventory/data/model/inventory_model.dart';
import 'package:asset_management_api/features/inventory/data/source/inventory_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class InventoryLocalDataSourceImpl implements InventoryLocalDataSource {
  InventoryLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<InventoryModel> findInventory(String params) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
        SELECT
        	l1.id AS id,
          l1.name AS name,
          SUM(a.quantity) AS quantity,
          l1.box_type AS box_type
        FROM
            t_assets AS a
        LEFT JOIN t_locations AS l1 ON a.location_id = l1.id 
        LEFT JOIN t_locations AS l2 ON l1.parent_id = l2.id
        WHERE l2.name = ?
        GROUP BY
        	l1.id,
          l1.name,
          a.asset_model_id, 
          l1.location_type
        ''',
        [params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Not Found');
      }

      final boxModel =
          response.map((e) => InventoryBoxModel.fromDatabse(e.fields)).toList();

      final totalBox = boxModel.length;

      return InventoryModel(
        boxs: boxModel,
        totalBox: totalBox,
      );
    } on NotFoundException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: 'Terjadi kesalahan: $e');
    }
  }
}
