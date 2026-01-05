// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/movement/domain/usecases/create_movement_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler movementInjector(Handler handler) {
  return handler
      .use(provider<CreateMovementUseCase>((_) => createMovementUseCase));
}
