// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/preparation_template/data/model/preparation_template_item_model.dart';
import 'package:asset_management_api/features/preparation_template/data/model/preparation_template_model.dart';

abstract class PreparationTemplateLocalDataSource {
  // Preparation Template
  Future<PreparationTemplateModel> createPreparationTemplate({
    required PreparationTemplateModel params,
  });
  Future<List<PreparationTemplateModel>> findAllPreparationTemplate();

  // Preparation Template Item
  Future<List<PreparationTemplateItemModel>> createPreparationTemplateItem({
    required List<PreparationTemplateItemModel> params,
    required int templateId,
  });
  Future<List<PreparationTemplateItemModel>>
      findAllPreparationTemplateItemByTemplateId({
    required int params,
  });
}
