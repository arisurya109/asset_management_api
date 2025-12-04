// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation_item/data/model/preparation_item_model.dart';

abstract class PreparationItemLocalDataSource {
  Future<List<PreparationItemModel>> findAllPreparationItemByPreparationId({
    required int preparationId,
  });
  Future<List<PreparationItemModel>>
      findAllPreparationItemByPreparationDetailId({
    required int preparationDetailId,
  });
  Future<PreparationItemModel> createPreparationItem({
    required PreparationItemModel params,
  });
  Future<String> deletePreparationItem({
    required int id,
  });
}
