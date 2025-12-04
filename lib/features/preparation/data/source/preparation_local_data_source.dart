// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';

abstract class PreparationLocalDataSource {
  Future<List<PreparationModel>> findAllPreparation();
  Future<PreparationModel> findPreparationById(int params);
  Future<PreparationModel> createPreparation(PreparationModel params);
  Future<PreparationModel> updateStatusAssignedPreparation({
    required int id,
    required int userId,
  });
  Future<PreparationModel> updateStatusPickingPreparation({
    required int id,
    required int userId,
  });
  Future<PreparationModel> updateStatusReadyPreparation({
    required int id,
    required int userId,
    required int locationId,
    required int totalBox,
  });
  Future<PreparationModel> updateStatusApprovedPreparation({
    required int id,
    required int userId,
  });
  Future<PreparationModel> updateStatusCompletedPreparation({
    required int id,
    required int userId,
    required List<int> fileBytes,
    required String originalName,
  });
  Future<PreparationModel> updateStatusCancelledPreparation({
    required int id,
    required int userId,
  });
}
