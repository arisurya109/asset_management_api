// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/index.dart' as index;
import '../routes/api/vendor/index.dart' as api_vendor_index;
import '../routes/api/vendor/[id].dart' as api_vendor_$id;
import '../routes/api/user/index.dart' as api_user_index;
import '../routes/api/user/[id].dart' as api_user_$id;
import '../routes/api/purchase_order/index.dart' as api_purchase_order_index;
import '../routes/api/purchase_order/[id].dart' as api_purchase_order_$id;
import '../routes/api/preparation/template/index.dart' as api_preparation_template_index;
import '../routes/api/preparation/template/[id].dart' as api_preparation_template_$id;
import '../routes/api/module/index.dart' as api_module_index;
import '../routes/api/module/[id].dart' as api_module_$id;
import '../routes/api/login/index.dart' as api_login_index;
import '../routes/api/location/index.dart' as api_location_index;
import '../routes/api/location/[id].dart' as api_location_$id;
import '../routes/api/change_password/index.dart' as api_change_password_index;
import '../routes/api/auto_login/index.dart' as api_auto_login_index;
import '../routes/api/assets/index.dart' as api_assets_index;
import '../routes/api/assets/[id]/transfer.dart' as api_assets_$id_transfer;
import '../routes/api/assets/[id]/index.dart' as api_assets_$id_index;
import '../routes/api/asset_type/index.dart' as api_asset_type_index;
import '../routes/api/asset_type/[id].dart' as api_asset_type_$id;
import '../routes/api/asset_model/index.dart' as api_asset_model_index;
import '../routes/api/asset_model/[id].dart' as api_asset_model_$id;
import '../routes/api/asset_category/index.dart' as api_asset_category_index;
import '../routes/api/asset_category/[id].dart' as api_asset_category_$id;
import '../routes/api/asset_brand/index.dart' as api_asset_brand_index;
import '../routes/api/asset_brand/[id].dart' as api_asset_brand_$id;

import '../routes/_middleware.dart' as middleware;

void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(buildRootHandler()).handler;
  final server = await serve(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/api/asset_brand', (context) => buildApiAssetBrandHandler()(context))
    ..mount('/api/asset_category', (context) => buildApiAssetCategoryHandler()(context))
    ..mount('/api/asset_model', (context) => buildApiAssetModelHandler()(context))
    ..mount('/api/asset_type', (context) => buildApiAssetTypeHandler()(context))
    ..mount('/api/assets/<id>', (context,id,) => buildApiAssets$idHandler(id,)(context))
    ..mount('/api/assets', (context) => buildApiAssetsHandler()(context))
    ..mount('/api/auto_login', (context) => buildApiAutoLoginHandler()(context))
    ..mount('/api/change_password', (context) => buildApiChangePasswordHandler()(context))
    ..mount('/api/location', (context) => buildApiLocationHandler()(context))
    ..mount('/api/login', (context) => buildApiLoginHandler()(context))
    ..mount('/api/module', (context) => buildApiModuleHandler()(context))
    ..mount('/api/preparation/template', (context) => buildApiPreparationTemplateHandler()(context))
    ..mount('/api/purchase_order', (context) => buildApiPurchaseOrderHandler()(context))
    ..mount('/api/user', (context) => buildApiUserHandler()(context))
    ..mount('/api/vendor', (context) => buildApiVendorHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildApiAssetBrandHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_asset_brand_index.onRequest(context,))..all('/<id>', (context,id,) => api_asset_brand_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiAssetCategoryHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_asset_category_index.onRequest(context,))..all('/<id>', (context,id,) => api_asset_category_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiAssetModelHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_asset_model_index.onRequest(context,))..all('/<id>', (context,id,) => api_asset_model_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiAssetTypeHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_asset_type_index.onRequest(context,))..all('/<id>', (context,id,) => api_asset_type_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiAssets$idHandler(String id,) {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/transfer', (context) => api_assets_$id_transfer.onRequest(context,id,))..all('/', (context) => api_assets_$id_index.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiAssetsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_assets_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiAutoLoginHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_auto_login_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiChangePasswordHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_change_password_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiLocationHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_location_index.onRequest(context,))..all('/<id>', (context,id,) => api_location_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiLoginHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_login_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiModuleHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_module_index.onRequest(context,))..all('/<id>', (context,id,) => api_module_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiPreparationTemplateHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_preparation_template_index.onRequest(context,))..all('/<id>', (context,id,) => api_preparation_template_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiPurchaseOrderHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_purchase_order_index.onRequest(context,))..all('/<id>', (context,id,) => api_purchase_order_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiUserHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_user_index.onRequest(context,))..all('/<id>', (context,id,) => api_user_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildApiVendorHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_vendor_index.onRequest(context,))..all('/<id>', (context,id,) => api_vendor_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}

