// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/locations/data/model/location_model.dart';

abstract class LocationLocalDataSource {
  // Location
  Future<List<LocationModel>> findAllLocation();
  Future<LocationModel> createLocation(LocationModel params);
  Future<LocationModel> updateLocation(LocationModel params);
  Future<LocationModel> findByIdLocation(int params);

  // Location Detail
  Future<List<LocationDetailModel>> findAllLocationDetail();
  Future<LocationDetailModel> createLocationDetail(LocationDetailModel params);
  Future<LocationDetailModel> updateLocationDetail(LocationDetailModel params);
  Future<LocationDetailModel> findByIdLocationDetail(int params);

  // Location Team
  Future<List<LocationTeamModel>> findAllLocationTeam();
  Future<LocationTeamModel> createLocationTeam(LocationTeamModel params);
  Future<LocationTeamModel> updateLocationTeam(LocationTeamModel params);
  Future<LocationTeamModel> findByIdLocationTeam(int params);

  // Location Rack
  Future<List<LocationRackModel>> findAllLocationRack();
  Future<LocationRackModel> createLocationRack(LocationRackModel params);
  Future<LocationRackModel> updateLocationRack(LocationRackModel params);
  Future<LocationRackModel> findByIdLocationRack(int params);

  // Location Box
  Future<List<LocationBoxModel>> findAllLocationBox();
  Future<LocationBoxModel> createLocationBox(LocationBoxModel params);
  Future<LocationBoxModel> updateLocationBox(LocationBoxModel params);
  Future<LocationBoxModel> findByIdLocationBox(int params);
}
