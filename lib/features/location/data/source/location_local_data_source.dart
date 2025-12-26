// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/location/data/model/location_model.dart';

abstract class LocationLocalDataSource {
  Future<List<LocationModel>> findAllLocation();
  Future<LocationModel> createLocation(LocationModel params);
  Future<LocationModel> updateLocation(LocationModel params);
  Future<LocationModel> findByIdLocation(int params);

  Future<List<LocationModel>> findAllLocationStorage();
  Future<List<LocationModel>> findAllLocationNonStorage();
  Future<List<LocationModel>> findLocationByQuery({
    required String params,
  });
  Future<void> deleteLocationById(int params);
}
