// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';

abstract class PreparationLocalDataSource {
  Future<List<String>> getPreparationTypes();
  Future<PreparationModel> createPreparation({
    required PreparationModel params,
  });
  Future<List<PreparationModel>> findPreparationByPagination({
    required int page,
    required int limit,
    String? query,
  });
  Future<PreparationModel> updatePreparationStatus({
    required String params,
    required int userId,
  });
}
