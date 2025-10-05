// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/module_permission/module_permission_export.dart';
import 'package:asset_management_api/injectors/injector_export.dart';
import 'package:dart_frog/dart_frog.dart';

Handler moduleInjector(Handler handler) {
  return handler
      .use(
        provider<FindAllModulePermissionUseCase>(
          (_) => findAllModulePermissionUseCase,
        ),
      )
      .use(
        provider<FindModulePermissionByIdUseCase>(
          (_) => findModulePermissionByIdUseCase,
        ),
      );
}
