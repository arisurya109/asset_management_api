// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/categories/category_export.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler categoryInjector(Handler handler) {
  return handler
      .use(provider<CreateCategoryUseCase>((_) => createCategoryUseCase))
      .use(provider<FindAllCategoryUseCase>((_) => findAllCategoryUseCase))
      .use(provider<FindCategoryByIdUseCase>((_) => findCategoryByIdUseCase))
      .use(provider<UpdateCategoryUseCase>((_) => updateCategoryUseCase));
}
