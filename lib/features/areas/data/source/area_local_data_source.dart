// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/areas/data/model/area_model.dart';

abstract class AreaLocalDataSource {
  Future<List<AreaModel>> findAllArea();
  Future<AreaModel> findAreaById(int params);
}
