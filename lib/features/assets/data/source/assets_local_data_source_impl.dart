import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/assets/data/model/assets_response_model.dart';
import 'package:asset_management_api/features/assets/data/source/assets_local_data_source.dart';

class AssetsLocalDataSourceImpl implements AssetsLocalDataSource {
  AssetsLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<List<AssetsResponseModel>> findAllAssets() async {
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
      ''',
    );

    if (response.firstOrNull == null) {
      throw NotFoundException(message: 'Assets is empty');
    }

    return response.map((e) => AssetsResponseModel.fromMap(e.fields)).toList();
  }
}
