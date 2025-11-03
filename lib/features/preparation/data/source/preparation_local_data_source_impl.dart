// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/core/helpers/asset.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_detail_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_item_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_template_item_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_template_model.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class PreparationLocalDataSourceImpl implements PreparationLocalDataSource {
  PreparationLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<PreparationTemplateModel> createPreparationTemplate(
    PreparationTemplateModel params,
  ) async {
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
  Future<List<PreparationTemplateItemModel>> createPreparationTemplateItem(
    List<PreparationTemplateItemModel> params,
    int templateId,
  ) async {
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
  Future<String> deletePreparationTemplate(int params) async {
    try {
      final db = await _database.connection;

      await db.query(
        'UPDATE t_preparation_templates SET is_active = ? WHERE id = ?',
        [0, params],
      );

      return 'Successfully delete preparation template';
    } on DeleteException {
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
      findAllPreparationTemplateItemByTemplateId(
    int params,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
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

  @override
  Future<PreparationModel> createPreparation(PreparationModel params) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final templateCode = AssetHelper.templateCode;

        final response = await txn.query(
          '''
          SELECT COUNT(id) FROM t_preparations 
          WHERE DATE(created_at) = CURDATE()
          ''',
        );

        const width = 4;

        final count = response.first.fields['COUNT(id)'] as int;
        final lastCode = (count + 1).toString().padLeft(width, '0');

        final assetCode = 'AP-$templateCode$lastCode';

        final newPreparation = await txn.query('''
          INSERT INTO t_preparations
            (preparation_code, destination_id, assigned_id, notes, created_by)
          VALUES
            (?, ?, ?, ?, ?)
          ''', [
          assetCode,
          params.destinationId,
          params.assignedId,
          params.notes,
          params.createdById,
        ]);

        if (newPreparation.insertId == null || newPreparation.insertId == 0) {
          throw CreateException(
            message: 'Failed to create preparation, please try again',
          );
        } else {
          final responsePreparation = await txn.query(
            '''
            SELECT
              p.id AS id,
              p.preparation_code AS preparation_code,
              p.destination_id AS destination_id,
              l.name AS destination,
              p.assigned_id AS assigned_id,
              a.name AS assigned,
              p.temporary_location_id AS temporary_location_id,
              t.name AS temporary_location,
              p.total_box AS total_box,
              p.status AS status,
              p.notes AS notes,
              p.created_by AS created_by_id,
              c.name AS created_by,
              p.updated_by AS updated_by_id,
              u.name AS updated_by
            FROM
              t_preparations AS p
            LEFT JOIN t_locations AS l ON p.destination_id = l.id
            LEFT JOIN t_users AS a ON p.assigned_id = a.id
            LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
            LEFT JOIN t_users AS c ON p.created_by = c.id
            LEFT JOIN t_users AS u ON p.updated_by = u.id
            WHERE p.id = ?
            ''',
            [newPreparation.insertId],
          );

          return responsePreparation.first.fields;
        }
      });
      return PreparationModel.fromDatabase(response!);
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
  Future<List<PreparationModel>> findAllPreparation() async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
        SELECT
          p.id AS id,
          p.preparation_code AS preparation_code,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.assigned_id AS assigned_id,
          a.name AS assigned,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.total_box AS total_box,
          p.status AS status,
          p.notes AS notes,
          p.created_by AS created_by_id,
          c.name AS created_by,
          p.updated_by AS updated_by_id,
          u.name AS updated_by
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_users AS a ON p.assigned_id = a.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_by = c.id
        LEFT JOIN t_users AS u ON p.updated_by = u.id
        ''',
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Preparation is not found');
      } else {
        return response
            .map((e) => PreparationModel.fromDatabase(e.fields))
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

  @override
  Future<PreparationModel> findPreparationById(int params) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
        SELECT
          p.id AS id,
          p.preparation_code AS preparation_code,
          p.destination_id AS destination_id,
          l.name AS destination,
          p.assigned_id AS assigned_id,
          a.name AS assigned,
          p.temporary_location_id AS temporary_location_id,
          t.name AS temporary_location,
          p.total_box AS total_box,
          p.status AS status,
          p.notes AS notes,
          p.created_by AS created_by_id,
          c.name AS created_by,
          p.updated_by AS updated_by_id,
          u.name AS updated_by
        FROM
          t_preparations AS p
        LEFT JOIN t_locations AS l ON p.destination_id = l.id
        LEFT JOIN t_users AS a ON p.assigned_id = a.id
        LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
        LEFT JOIN t_users AS c ON p.created_by = c.id
        LEFT JOIN t_users AS u ON p.updated_by = u.id
        WHERE p.id = ?
        ''',
        [params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Preparation is not found');
      } else {
        return PreparationModel.fromDatabase(response.first.fields);
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

  @override
  Future<PreparationModel> updatePreparation(PreparationModel params) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final datas = params.toDatabasePartial();

        if (datas.isEmpty) {
          throw UpdateException(message: 'Failed updated please try again');
        }

        final setClause = datas.keys.map((e) => '$e = ?').join(', ');

        final values = datas.values.toList()..add(params.id);

        final sql = 'UPDATE t_preparations SET $setClause WHERE id = ?';

        await txn.query(sql, values);

        final responsePreparation = await txn.query(
          '''
            SELECT
              p.id AS id,
              p.preparation_code AS preparation_code,
              p.destination_id AS destination_id,
              l.name AS destination,
              p.assigned_id AS assigned_id,
              a.name AS assigned,
              p.temporary_location_id AS temporary_location_id,
              t.name AS temporary_location,
              p.total_box AS total_box,
              p.status AS status,
              p.notes AS notes,
              p.created_by AS created_by_id,
              c.name AS created_by,
              p.updated_by AS updated_by_id,
              u.name AS updated_by
            FROM
              t_preparations AS p
            LEFT JOIN t_locations AS l ON p.destination_id = l.id
            LEFT JOIN t_users AS a ON p.assigned_id = a.id
            LEFT JOIN t_locations AS t ON p.temporary_location_id = t.id
            LEFT JOIN t_users AS c ON p.created_by = c.id
            LEFT JOIN t_users AS u ON p.updated_by = u.id
            WHERE p.id = ?
            ''',
          [params.id],
        );

        return responsePreparation.first.fields;
      });
      return PreparationModel.fromDatabase(response!);
    } on UpdateException {
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
  Future<PreparationDetailModel> createPreparationDetail(
    PreparationDetailModel params,
  ) async {
    try {
      final db = await _database.connection;

      final newPrepDetail = await db.query(
        '''
        INSERT INTO t_preparation_details
          (preparation_id, asset_model_id, quantity_target)
        VALUES
          (?, ?, ?)
        ''',
        [params.preparationId, params.assetModelId, params.quantityTarget],
      );

      if (newPrepDetail.insertId == null || newPrepDetail.insertId == 0) {
        throw CreateException(message: 'Failed to insert preparation detail');
      } else {
        final responsePrepDetail = await db.query(
          '''
          SELECT
            pd.id AS id,
            pd.preparation_id AS preparation_id,
            pd.asset_model_id AS asset_model_id,
            m.name AS asset_model,
            t.name AS asset_type,
            c.name AS asset_category,
            b.name AS asset_brand,
            pd.quantity_target AS quantity_target,
            pd.quantity_picked AS quantity_picked,
            pd.quantity_missing AS quantity_missing,
            pd.exception_status AS exception_status,
            pd.exception_reason AS exception_reason,
            pd.status AS status,
            pd.notes AS notes
          FROM
            t_preparation_details AS pd
          LEFT JOIN t_asset_models AS m ON pd.asset_model_id = m.id
          LEFT JOIN t_asset_types AS t ON m.type_id = t.id
          LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
          LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
          WHERE pd.id = ? 
          ''',
          [newPrepDetail.insertId],
        );

        return PreparationDetailModel.fromDatabase(
          responsePrepDetail.first.fields,
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
  Future<List<PreparationDetailModel>> findAllPreparationDetailByPreparationId(
    int params,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
          SELECT
            pd.id AS id,
            pd.preparation_id AS preparation_id,
            pd.asset_model_id AS asset_model_id,
            m.name AS asset_model,
            t.name AS asset_type,
            c.name AS asset_category,
            b.name AS asset_brand,
            pd.quantity_target AS quantity_target,
            pd.quantity_picked AS quantity_picked,
            pd.quantity_missing AS quantity_missing,
            pd.exception_status AS exception_status,
            pd.exception_reason AS exception_reason,
            pd.status AS status,
            pd.notes AS notes
          FROM
            t_preparation_details AS pd
          LEFT JOIN t_asset_models AS m ON pd.asset_model_id = m.id
          LEFT JOIN t_asset_types AS t ON m.type_id = t.id
          LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
          LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
          WHERE pd.preparation_id = ? 
          ''',
        [params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Preparation Detail is empty');
      } else {
        return response
            .map((e) => PreparationDetailModel.fromDatabase(e.fields))
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

  @override
  Future<PreparationDetailModel> findPreparationDetailById(
    int params,
    int preparationId,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
          SELECT
            pd.id AS id,
            pd.preparation_id AS preparation_id,
            pd.asset_model_id AS asset_model_id,
            m.name AS asset_model,
            t.name AS asset_type,
            c.name AS asset_category,
            b.name AS asset_brand,
            pd.quantity_target AS quantity_target,
            pd.quantity_picked AS quantity_picked,
            pd.quantity_missing AS quantity_missing,
            pd.exception_status AS exception_status,
            pd.exception_reason AS exception_reason,
            pd.status AS status,
            pd.notes AS notes
          FROM
            t_preparation_details AS pd
          LEFT JOIN t_asset_models AS m ON pd.asset_model_id = m.id
          LEFT JOIN t_asset_types AS t ON m.type_id = t.id
          LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
          LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
          WHERE pd.preparation_id = ? AND pd.id = ?
          ''',
        [preparationId, params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Preparation Detail is not found');
      } else {
        return PreparationDetailModel.fromDatabase(response.first.fields);
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

  @override
  Future<PreparationDetailModel> updatePreparationDetail(
    PreparationDetailModel params,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final datas = params.toDatabasePartial();

        if (datas.isEmpty) {
          throw UpdateException(message: 'Failed updated please try again');
        }

        final setClause = datas.keys.map((e) => '$e = ?').join(', ');

        final values = datas.values.toList()
          ..add(params.id)
          ..add(params.preparationId);

        final sql = '''
            UPDATE t_preparation_details SET $setClause WHERE id = ? AND preparation_id = ?
            ''';

        await txn.query(sql, values);

        final responsePrepDetail = await db.query(
          '''
          SELECT
            pd.id AS id,
            pd.preparation_id AS preparation_id,
            pd.asset_model_id AS asset_model_id,
            m.name AS asset_model,
            t.name AS asset_type,
            c.name AS asset_category,
            b.name AS asset_brand,
            pd.quantity_target AS quantity_target,
            pd.quantity_picked AS quantity_picked,
            pd.quantity_missing AS quantity_missing,
            pd.exception_status AS exception_status,
            pd.exception_reason AS exception_reason,
            pd.status AS status,
            pd.notes AS notes
          FROM
            t_preparation_details AS pd
          LEFT JOIN t_asset_models AS m ON pd.asset_model_id = m.id
          LEFT JOIN t_asset_types AS t ON m.type_id = t.id
          LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
          LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
          WHERE pd.id = ? AND pd.preparation_id = ? 
          ''',
          [params.id, params.preparationId],
        );

        return responsePrepDetail.first.fields;
      });
      return PreparationDetailModel.fromDatabase(response!);
    } on UpdateException {
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
  Future<PreparationItemModel> createPreparationItem(
    PreparationItemModel params,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        // Get Asset Model Id dan Quantity yang ready
        final responseQuantityStorage = await txn.query(
          '''
          SELECT
            quantity,
            asset_model_id
          FROM
            t_assets
          WHERE id = ? AND location_id = ?
          ''',
          [params.assetId, params.locationId],
        );

        if (responseQuantityStorage.firstOrNull == null) {
          throw NotFoundException(
            message: 'Failed, The selected asset is invalid.',
          );
        }
        final stockInStorage =
            responseQuantityStorage.first.fields['quantity'] as int;

        final assetModelId =
            responseQuantityStorage.first.fields['asset_model_id'] as int;

        if (params.quantity! > stockInStorage) {
          throw CreateException(message: 'Quantity exceeds stock on the rack');
        }

        // Check apakah asset yang di scan sesuai dengan permintaan
        final responsePreparationDetail = await txn.query(
          '''
          SELECT * FROM t_preparation_details 
          WHERE asset_model_id = ? AND preparation_id = ?
          ''',
          [assetModelId, params.preparationDetailId],
        );

        if (responsePreparationDetail.firstOrNull == null) {
          throw NotFoundException(
            message: 'Failed, The selected asset is invalid',
          );
        }

        final preparationDetailMap = responsePreparationDetail.first.fields;

        final qtyTarget = preparationDetailMap['quantity_target'] as int;
        final qtyPicked = preparationDetailMap['quantity_picked'] as int;

        if (qtyPicked >= qtyTarget) {
          throw Exception('Quantity already completed');
        }

        // Check duplicate Asset di Preparation Detail Items
        final dupCheck = await txn.query(
          '''
          SELECT id FROM t_preparation_detail_items
          WHERE preparation_detail_id = ? AND asset_id = ?
          ''',
          [params.preparationDetailId, params.assetId],
        );

        if (dupCheck.firstOrNull != null) {
          throw CreateException(message: 'Asset already picked');
        }

        // Insert Preparation Detail Item
        final prepItem = await txn.query('''
          INSERT INTO t_preparation_detail_items
            (preparation_detail_id, asset_id, picked_by, quantity, location_id)
          VALUES
            (?, ?, ?, ?, ?)
          ''', [
          params.preparationDetailId,
          params.assetId,
          params.pickedById,
          params.quantity,
          params.locationId,
        ]);

        if (prepItem.insertId == null) {
          throw CreateException(message: 'Failed to insert assets');
        }

        // Jika quantity Picked 0, update status IN_PROGRESS
        if (qtyPicked == 0) {
          await txn.query(
            '''
            UPDATE t_preparation_details
            SET quantity_picked = quantity_picked + 1, status = 'IN_PROGRESS'
            WHERE id = ?
            ''',
            [params.preparationDetailId],
          );
          // Jika Quantity Target sudah terpenuhi maka update status READY
        } else if (qtyTarget == (qtyPicked + 1)) {
          await txn.query(
            '''
            UPDATE t_preparation_details
            SET quantity_picked = quantity_picked + 1, status = 'READY'
            WHERE id = ?
            ''',
            [params.preparationDetailId],
          );
        } else {
          // Increment Quantity Picked
          await txn.query(
            '''
            UPDATE t_preparation_details
            SET quantity_picked = quantity_picked + 1
            WHERE id = ?
            ''',
            [params.preparationDetailId],
          );
        }
        // Get hasil preparation Item
        final responsePrepItem = await txn.query(
          '''
          SELECT
            pi.id AS id,
            pi.preparation_detail_id AS preparation_detail_id,
            pd.preparation_id AS preparation_id,
            pi.asset_id AS asset_id,
            a.asset_model_id AS asset_model_id,
            a.asset_code AS asset_code,
            m.name AS asset_model,
            t.name AS asset_type,
            b.name AS asset_brand,
            c.name AS asset_category,
            pi.picked_by AS picked_by_id,
            u.name AS picked_by,
            pi.quantity AS quantity,
            pi.location_id AS location_id,
            l.name AS location
          FROM
            t_preparation_detail_items AS pi
          LEFT JOIN t_preparation_details AS pd ON pi.preparation_detail_id = pd.id
          LEFT JOIN t_assets AS a ON pi.asset_id = a.id
          LEFT JOIN t_asset_models AS m ON a.asset_model_id = m.id
          LEFT JOIN t_asset_types AS t ON m.type_id = t.id
          LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
          LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
          LEFT JOIN t_users AS u ON pi.picked_by = u.id
          LEFT JOIN t_locations AS l ON pi.location_id = l.id
          WHERE pi.id = ?
          ''',
          [prepItem.insertId],
        );

        return responsePrepItem.first.fields;
      });

      return PreparationItemModel.fromDatabase(response!);
    } on NotFoundException {
      rethrow;
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
  Future<List<PreparationItemModel>>
      findAllPreparationItemByPreparationDetailId(
    int params,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
          SELECT
            pi.id AS id,
            pi.preparation_detail_id AS preparation_detail_id,
            pd.preparation_id AS preparation_id,
            pi.asset_id AS asset_id,
            a.asset_model_id AS asset_model_id,
            a.asset_code AS asset_code,
            m.name AS asset_model,
            t.name AS asset_type,
            b.name AS asset_brand,
            c.name AS asset_category,
            pi.picked_by AS picked_by_id,
            u.name AS picked_by,
            pi.quantity AS quantity,
            pi.location_id AS location_id,
            l.name AS location
          FROM
            t_preparation_detail_items AS pi
          LEFT JOIN t_preparation_details AS pd ON pi.preparation_detail_id = pd.id
          LEFT JOIN t_assets AS a ON pi.asset_id = a.id
          LEFT JOIN t_asset_models AS m ON a.asset_model_id = m.id
          LEFT JOIN t_asset_types AS t ON m.type_id = t.id
          LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
          LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
          LEFT JOIN t_users AS u ON pi.picked_by = u.id
          LEFT JOIN t_locations AS l ON pi.location_id = l.id
          WHERE pi.preparation_detail_id = ?
          ''',
        [params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Assets is empty');
      } else {
        return response
            .map((e) => PreparationItemModel.fromDatabase(e.fields))
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

  @override
  Future<List<PreparationItemModel>> findAllPreparationItemByPreparationId(
    int params,
  ) async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        '''
          SELECT
            pi.id AS id,
            pi.preparation_detail_id AS preparation_detail_id,
            pd.preparation_id AS preparation_id,
            pi.asset_id AS asset_id,
            a.asset_model_id AS asset_model_id,
            a.asset_code AS asset_code,
            m.name AS asset_model,
            t.name AS asset_type,
            b.name AS asset_brand,
            c.name AS asset_category,
            pi.picked_by AS picked_by_id,
            u.name AS picked_by,
            pi.quantity AS quantity,
            pi.location_id AS location_id,
            l.name AS location
          FROM
            t_preparation_detail_items AS pi
          LEFT JOIN t_preparation_details AS pd ON pi.preparation_detail_id = pd.id
          LEFT JOIN t_assets AS a ON pi.asset_id = a.id
          LEFT JOIN t_asset_models AS m ON a.asset_model_id = m.id
          LEFT JOIN t_asset_types AS t ON m.type_id = t.id
          LEFT JOIN t_asset_brands AS b ON m.brand_id = b.id
          LEFT JOIN t_asset_categories AS c ON m.category_id = c.id
          LEFT JOIN t_users AS u ON pi.picked_by = u.id
          LEFT JOIN t_locations AS l ON pi.location_id = l.id
          WHERE pd.preparation_id = ?
          ''',
        [params],
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(message: 'Assets is empty');
      } else {
        return response
            .map((e) => PreparationItemModel.fromDatabase(e.fields))
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

  @override
  Future<PreparationModel> completePreparationPicking(PreparationModel params) {
    // TODO: implement completePreparationPicking
    throw UnimplementedError();
  }

  @override
  Future<PreparationModel> dispatchPreparation(PreparationModel params) {
    // TODO: implement dispatchPreparation
    throw UnimplementedError();
  }
}
