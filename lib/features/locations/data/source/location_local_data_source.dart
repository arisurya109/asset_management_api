// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/locations/data/model/location_model.dart';

abstract class LocationLocalDataSource {
  Future<List<LocationModel>> findAllLocation();
  Future<LocationModel> findLocationById(int params);
  Future<LocationModel> createLocation(LocationModel params);
  Future<LocationModel> updateLocation(LocationModel params);
}
