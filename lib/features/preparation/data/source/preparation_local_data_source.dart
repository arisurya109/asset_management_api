// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation/data/model/preparation_template_item_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_template_model.dart';

abstract class PreparationLocalDataSource {
  // Preparation Template
  Future<PreparationTemplateModel> createPreparationTemplate(
    PreparationTemplateModel params,
  );
  Future<List<PreparationTemplateModel>> findAllPreparationTemplate();
  Future<String> deletePreparationTemplate(int params);

  // Preparation Template Item
  Future<List<PreparationTemplateItemModel>> createPreparationTemplateItem(
    List<PreparationTemplateItemModel> params,
    int templateId,
  );
  Future<List<PreparationTemplateItemModel>>
      findAllPreparationTemplateItemByTemplateId(
    int params,
  );
}
