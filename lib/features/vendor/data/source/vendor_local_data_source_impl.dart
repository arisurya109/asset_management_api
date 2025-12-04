// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/error/exception.dart';
import 'package:asset_management_api/features/vendor/data/model/vendor_model.dart';
import 'package:asset_management_api/features/vendor/data/source/vendor_local_data_source.dart';

class VendorLocalDataSourceImpl implements VendorLocalDataSource {
  VendorLocalDataSourceImpl(this._database);

  final Database _database;

  @override
  Future<VendorModel> createVendor(VendorModel params) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final checkName = await txn.query(
          'SELECT id FROM t_vendors WHERE name = UPPER(?)',
          [params.name],
        );

        if (checkName.firstOrNull != null) {
          throw CreateException(
            message: 'Failed to create vendor, name already exists',
          );
        }

        final newVendor = await txn.query('''
        INSERT INTO t_vendors (name, init, phone, description, created_by)
        VALUES (?, ?, ?, ?, ?)
        ''', [
          params.name,
          params.init,
          params.phone,
          params.description,
          params.createdBy,
        ]);

        if (newVendor.insertId == null || newVendor.insertId == 0) {
          throw CreateException(
            message: 'Failed to create vendor, please try again',
          );
        }

        final response = await txn.query(
          'SELECT id, name, init, phone, description FROM t_vendors WHERE id = ?',
          [newVendor.insertId],
        );

        return response.first.fields;
      });

      return VendorModel.fromDatabase(response!);
    } catch (e) {
      throw CreateException(message: e.toString());
    }
  }

  @override
  Future<List<VendorModel>> findAllVendor() async {
    try {
      final db = await _database.connection;

      final response = await db.query(
        'SELECT id, name, init, phone, description FROM t_vendors',
      );

      if (response.firstOrNull == null) {
        throw NotFoundException(
          message: 'Vendor is empty, please create first vendor',
        );
      }

      return response.map((e) => VendorModel.fromDatabase(e.fields)).toList();
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<VendorModel> updateVendor(VendorModel params) async {
    try {
      final db = await _database.connection;

      final response = await db.transaction((txn) async {
        final vendorExists = await txn.query(
          'SELECT id FROM t_vendors WHERE id = ?',
          [params.id],
        );

        if (vendorExists.firstOrNull == null) {
          throw UpdateException(message: 'Failed update, vendor not found');
        }

        final newVendor = await txn.query('''
        UPDATE t_vendors
        SET name = ?, init = ?, phone = ?, description = ?, updated_by = ?, updated_at = CURDATE()
        WHERE id = ?
        ''', [
          params.name,
          params.init,
          params.phone,
          params.description,
          params.updatedBy,
          params.id,
        ]);

        if (newVendor.affectedRows == 0 || newVendor.affectedRows == null) {
          throw UpdateException(
            message: 'Failed update vendor, please try again',
          );
        }

        final responseVendor = await txn.query(
          'SELECT id, name, init, phone, description FROM t_vendors WHERE id = ?',
          [params.id],
        );

        return responseVendor.first.fields;
      });
      return VendorModel.fromDatabase(response!);
    } catch (e) {
      throw UpdateException(message: e.toString());
    }
  }
}
