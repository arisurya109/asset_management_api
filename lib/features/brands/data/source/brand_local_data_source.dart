// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/brands/data/model/brand_model.dart';

abstract class BrandLocalDataSource {
  Future<BrandModel> createBrand(BrandModel params);
  Future<List<BrandModel>> findAllBrand();
  Future<List<BrandModel>> findBrandByIdAsset(int params);
  Future<BrandModel> findBrandById(int params);
  Future<BrandModel> updateBrand(BrandModel params);
}
