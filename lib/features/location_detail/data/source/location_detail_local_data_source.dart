// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/location_detail/data/model/location_detail_model.dart';

abstract class LocationDetailLocalDataSource {
  Future<LocationDetailModel> createLocationDetail(LocationDetailModel params);
  Future<List<LocationDetailModel>> findAllLocationDetail();
  Future<LocationDetailModel> updateLocationDetail(LocationDetailModel params);
}
