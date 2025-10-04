// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/users/domain/usecases/change_password_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/create_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/find_all_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/find_by_id_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/login_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/update_status_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/update_user_use_case.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler userInjector(Handler handler) {
  return handler
      .use(provider<CreateUserUseCase>((_) => createUserUseCase))
      .use(provider<FindAllUserUseCase>((_) => findAllUserUseCase))
      .use(provider<FindByIdUserUseCase>((_) => findByIdUserUseCase))
      .use(provider<UpdateStatusUserUseCase>((_) => updateStatusUserUseCase))
      .use(provider<UpdateUserUseCase>((_) => updateUserUseCase))
      .use(provider<ChangePasswordUseCase>((_) => changePasswordUseCase))
      .use(provider<LoginUseCase>((_) => loginUseCase));
}
