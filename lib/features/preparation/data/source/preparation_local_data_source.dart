// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/location/data/model/location_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';

abstract class PreparationLocalDataSource {
  Future<List<PreparationModel>> findAllPreparation();
  Future<PreparationModel> findPreparationById(int params);
  Future<PreparationModel> createPreparation(PreparationModel params);
  Future<PreparationModel> updateStatusPreparation({
    required int id,
    required String status,
    required int userId,
    int? totalBox,
    int? locationId,
    String? remarks,
  });
  Future<List<PreparationModel>> findPreparationByCodeOrDestination({
    required String params,
  });
  Future<List<LocationModel>> findDestinationExternal();
  Future<List<LocationModel>> findDestinationInternal();
}
