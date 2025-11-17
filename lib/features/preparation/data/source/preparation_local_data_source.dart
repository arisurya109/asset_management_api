// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/features/preparation/data/model/preparation_detail_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_item_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
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

  // Preparation
  Future<List<PreparationModel>> findAllPreparation();
  Future<PreparationModel> findPreparationById(int params);
  Future<PreparationModel> createPreparation(PreparationModel params);
  Future<PreparationModel> updatePreparation(PreparationModel params);
  Future<PreparationModel> completePreparationPicking(PreparationModel params);
  Future<PreparationModel> dispatchPreparation(PreparationModel params);
  Future<PreparationModel> completedPreparation(
    PreparationModel params,
    List<int> fileBytes,
    String originalName,
  );
  Future<File> findDocumentPreparationById(int params);

  // PreparationDetail
  Future<List<PreparationDetailModel>> findAllPreparationDetailByPreparationId(
    int params,
  );
  Future<PreparationDetailModel> findPreparationDetailById(
    int params,
    int preparationId,
  );
  Future<PreparationDetailModel> createPreparationDetail(
    PreparationDetailModel params,
  );
  Future<PreparationDetailModel> updatePreparationDetail(
    PreparationDetailModel params,
  );

  // Preparation Item
  Future<PreparationItemModel> createPreparationItem(
    PreparationItemModel params,
  );
  Future<List<PreparationItemModel>>
      findAllPreparationItemByPreparationDetailId(
    int params,
  );
  Future<List<PreparationItemModel>> findAllPreparationItemByPreparationId(
    int params,
  );
}
