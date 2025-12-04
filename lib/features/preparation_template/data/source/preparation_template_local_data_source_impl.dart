// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/preparation_template/data/model/preparation_template_item_model.dart';
import 'package:asset_management_api/features/preparation_template/data/model/preparation_template_model.dart';
import 'package:asset_management_api/features/preparation_template/data/source/preparation_template_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class PreparationTemplateLocalDataSourceImpl
    implements PreparationTemplateLocalDataSource {
  PreparationTemplateLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<PreparationTemplateModel> createPreparationTemplate({
    required PreparationTemplateModel params,
  }) async {
    try {
      final db = await _database.connection;

      final checkName = await db.query(
        '''
        SELECT * FROM t_preparation_templates
        WHERE name = ?
        ''',
        [params.name],
      );

      if (checkName.firstOrNull != null) {
        throw CreateException(message: 'Name Already exists');
      }

      final result = await db.query(
        '''
        SELECT template_code FROM t_preparation_templates 
        ORDER BY id DESC LIMIT 1
        ''',
      );

      String newCode;
      if (result.isEmpty) {
        newCode = 'PT-001';
      } else {
        final lastCode = result.first['template_code'] as String;
        final lastNumber = int.parse(lastCode.split('-')[1]);
        newCode = 'PT-${(lastNumber + 1).toString().padLeft(3, '0')}';
      }

      final response = await db.query(
        '''
      INSERT INTO t_preparation_templates
        (template_code, name, description, created_by)
      VALUES
        (?, ?, ?, ?)
      ''',
        [newCode, params.name, params.description, params.createdById],
      );

      if (response.insertId == null || response.insertId == 0) {
        throw CreateException(
          message: 'Failed to create template preparation',
        );
      } else {
        final newPrepTemplate = await db.query(
          '''
        SELECT
        	pt.id AS id,
        	pt.template_code AS template_code,
        	pt.name AS name,
        	pt.is_active AS is_active,
        	pt.description AS description,
        	pt.created_by AS created_by_id,
        	u.name AS created_by,
        	pt.created_at AS created_at,
        	pt.updated_at AS updated_at
        FROM
        	t_preparation_templates AS pt
        LEFT JOIN t_users AS u ON pt.created_by = u.id
        WHERE pt.id = ?
        ''',
          [response.insertId],
        );

        return PreparationTemplateModel.fromDatabase(
          newPrepTemplate.first.fields,
        );
      }
    } on CreateException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<PreparationTemplateItemModel>> createPreparationTemplateItem({
    required List<PreparationTemplateItemModel> params,
    required int templateId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        for (final element in params) {
          await txn.query('''
          INSERT INTO t_preparation_template_items
            (template_id, model_id, quantity, notes)
          VALUES
            (?, ?, ?, ?)
          ''', [
            templateId,
            element.modelId,
            element.quantity,
            element.notes,
          ]);
        }

        final response = await txn.query(
          '''
        SELECT
        	pti.id AS id,
        	pti.template_id AS template_id,
        	pti.quantity AS quantity,
        	pti.notes AS notes,
        	m.name AS asset_model,
        	c.name AS asset_category,
        	t.name AS asset_type,
        	b.name AS asset_brand
        FROM
        	t_preparation_template_items AS pti
        LEFT JOIN t_asset_models AS m ON pti.model_id = m.id
        LEFT JOIN t_asset_types AS t ON m.type_id = t.id
        LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
        LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
        WHERE pti.template_id = ?
        ''',
          [templateId],
        );

        if (response.firstOrNull == null) {
          throw CreateException(
            message: 'Failed to create preparation template item',
          );
        } else {
          return response.map((e) => e.fields).toList();
        }
      });

      return response!.map(PreparationTemplateItemModel.fromDatabase).toList();
    } on CreateException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<PreparationTemplateModel>> findAllPreparationTemplate() async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
      SELECT
      	pt.id AS id,
      	pt.template_code AS template_code,
      	pt.name AS name,
      	pt.is_active AS is_active,
      	pt.description AS description,
      	pt.created_by AS created_by_id,
      	u.name AS created_by,
      	pt.created_at AS created_at,
      	pt.updated_at AS updated_at
      FROM
      	t_preparation_templates AS pt
      LEFT JOIN t_users AS u ON pt.created_by = u.id
      WHERE pt.is_active = ?
      ''',
        [1],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Preparation set is empty');
      }

      return response
          .map((e) => PreparationTemplateModel.fromDatabase(e.fields))
          .toList();
    } on NotFoundException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<PreparationTemplateItemModel>>
      findAllPreparationTemplateItemByTemplateId({required int params}) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
        SELECT
        	pti.id AS id,
        	pti.template_id AS template_id,
          pti.model_id AS model_id,
        	pti.quantity AS quantity,
        	pti.notes AS notes,
        	m.name AS asset_model,
        	c.name AS asset_category,
        	t.name AS asset_type,
        	b.name AS asset_brand
        FROM
        	t_preparation_template_items AS pti
        LEFT JOIN t_asset_models AS m ON pti.model_id = m.id
        LEFT JOIN t_asset_types AS t ON m.type_id = t.id
        LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
        LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
        WHERE pti.template_id = ?
        ''',
        [params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Assets is not found');
      } else {
        return response
            .map((e) => PreparationTemplateItemModel.fromDatabase(e.fields))
            .toList();
      }
    } on NotFoundException {
      rethrow;
    } on MySqlException catch (e) {
      throw DatabaseException(message: e.message);
    } on TimeoutException {
      throw DatabaseException(message: 'Database Request time out');
    } on FormatException catch (e) {
      throw DatabaseException(message: e.message);
    } catch (e) {
      throw DatabaseException(message: e.toString());
    }
  }
}
