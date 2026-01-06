// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/location/data/model/location_model.dart';
import 'package:asset_management_api/features/location/data/model/location_pagination_model.dart';

abstract class LocationLocalDataSource {
  Future<List<LocationModel>> findAllLocation();
  Future<LocationModel> createLocation(
    LocationModel params,
    int userId,
  );
  Future<LocationModel> updateLocation(LocationModel params);
  Future<LocationModel> findByIdLocation(int params);
  Future<List<LocationModel>> findLocationByQuery(String query);
  Future<List<LocationModel>> findLocationStorage();
  Future<List<LocationModel>> findLocationNonStorage();
  Future<List<String>> findAllLocationType();
  Future<String> deleteLocation({
    required int id,
    required int userId,
  });
  Future<LocationPaginationModel> findLocationByPagination({
    required int page,
    required int limit,
    String? query,
  });
}
