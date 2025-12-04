// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation_detail/data/model/preparation_detail_model.dart';

abstract class PreparationDetailLocalDataSource {
  Future<List<PreparationDetailModel>> findAllPreparationDetailByPreparationId({
    required int preparationId,
  });

  Future<PreparationDetailModel> findPreparationDetailById({
    required int id,
  });

  Future<PreparationDetailModel> createPreparationDetail({
    required PreparationDetailModel params,
  });

  Future<PreparationDetailModel> updatePreparationDetail({
    required PreparationDetailModel params,
  });

  Future<PreparationDetailModel> updateStatusProgressPreparationDetail({
    required int id,
    required int userId,
  });

  Future<PreparationDetailModel> updateStatusCompletedPreparationDetail({
    required int id,
    required int userId,
  });
}
