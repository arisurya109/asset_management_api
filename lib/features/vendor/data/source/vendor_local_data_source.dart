// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/vendor/data/model/vendor_model.dart';

abstract class VendorLocalDataSource {
  Future<VendorModel> createVendor(VendorModel params);
  Future<VendorModel> updateVendor(VendorModel params);
  Future<List<VendorModel>> findAllVendor();
}
