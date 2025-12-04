// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/preparation_detail/data/model/preparation_detail_model.dart';
import 'package:asset_management_api/features/preparation_detail/data/source/preparation_detail_local_data_source.dart';
import 'package:mysql1/mysql1.dart';

class PreparationDetailLocalDataSourceImpl
    implements PreparationDetailLocalDataSource {
  PreparationDetailLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<PreparationDetailModel> createPreparationDetail({
    required PreparationDetailModel params,
  }) async {
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
  Future<List<PreparationDetailModel>> findAllPreparationDetailByPreparationId({
    required int preparationId,
  }) async {
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
        [preparationId],
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
  Future<PreparationDetailModel> findPreparationDetailById({
    required int id,
  }) async {
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
          WHERE pd.id = ?
          ''',
        [id],
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
  Future<PreparationDetailModel> updatePreparationDetail({
    required PreparationDetailModel params,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final datas = params.toDatabasePartial();

        if (datas.isEmpty) {
          throw UpdateException(message: 'Failed updated please try again');
        }

        final setClause = datas.keys.map((e) => '$e = ?').join(', ');

        final values = datas.values.toList()..add(params.id);

        final sql = '''
            UPDATE t_preparation_details SET $setClause WHERE id = ?
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
          WHERE pd.id = ?
          ''',
          [params.id],
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
  Future<PreparationDetailModel> updateStatusCompletedPreparationDetail({
    required int id,
    required int userId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final getPreparationDetail = await txn.query(
          '''
          SELECT
          	pd.id AS id,
          	pd.preparation_id AS preparation_id,
          	p.assigned_id AS assigned_id,
          	pd.quantity_target AS quantity_target,
          	pd.quantity_picked AS quantity_picked,
          	pd.quantity_missing AS quantity_missing,
          	pd.status AS status
          FROM
          	t_preparation_details AS pd
          LEFT JOIN t_preparations AS p ON pd.preparation_id = p.id
          WHERE pd.id = ? AND p.assigned_id = ? AND pd.status = ?
          ''',
          [id, userId, 'PROGRESS'],
        );

        if (getPreparationDetail.firstOrNull == null ||
            getPreparationDetail.isEmpty) {
          throw UpdateException(message: 'Preparation detail not found');
        }

        final preparationDetail = getPreparationDetail.first.fields;

        final quantityMissing = preparationDetail['quantity_missing'] as int;
        final quantityPicked = preparationDetail['quantity_picked'] as int;
        final quantityTarget = preparationDetail['quantity_target'] as int;

        if ((quantityMissing + quantityPicked) != quantityTarget) {
          throw UpdateException(message: 'Failed, please check total quantity');
        }

        final responseNewPreparationDetail = await txn.query(
          'UPDATE t_preparation_details SET status = ? WHERE id = ?',
          ['COMPLETED', id],
        );

        if (responseNewPreparationDetail.affectedRows == null ||
            responseNewPreparationDetail.affectedRows == 0) {
          throw UpdateException(message: 'Failed, please try again');
        }

        final responsePrepDetail = await txn.query(
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
          [id],
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
  Future<PreparationDetailModel> updateStatusProgressPreparationDetail({
    required int id,
    required int userId,
  }) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final getPreparationDetail = await txn.query(
          '''
          SELECT
          	pd.id AS id,
          	pd.preparation_id AS preparation_id,
          	p.assigned_id AS assigned_id,
          	pd.quantity_target AS quantity_target,
          	pd.quantity_picked AS quantity_picked,
          	pd.quantity_missing AS quantity_missing,
          	pd.status AS status
          FROM
          	t_preparation_details AS pd
          LEFT JOIN t_preparations AS p ON pd.preparation_id = p.id
          WHERE pd.id = ? AND p.assigned_id = ? AND pd.status = ?
          ''',
          [id, userId, 'PENDING'],
        );

        if (getPreparationDetail.firstOrNull == null ||
            getPreparationDetail.isEmpty) {
          throw UpdateException(message: 'Preparation detail not found');
        }

        final responseNewPreparationDetail = await txn.query(
          'UPDATE t_preparation_details SET status = ? WHERE id = ?',
          ['PROGRESS', id],
        );

        if (responseNewPreparationDetail.affectedRows == null ||
            responseNewPreparationDetail.affectedRows == 0) {
          throw UpdateException(message: 'Failed, please try again');
        }

        final responsePrepDetail = await txn.query(
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
          [id],
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
}
