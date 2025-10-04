// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/users/datasource/repositories/user_repository_impl.dart';
import 'package:asset_management_api/features/users/datasource/source/user_local_data_source.dart';
import 'package:asset_management_api/features/users/datasource/source/user_local_data_source_impl.dart';
import 'package:asset_management_api/features/users/domain/repositories/user_repository.dart';
import 'package:asset_management_api/features/users/domain/usecases/change_password_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/create_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/find_all_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/find_by_id_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/login_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/update_status_user_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/update_user_use_case.dart';

final JwtService jwtService = JwtServiceImpl();
final Database database = Database();

// User
final UserLocalDataSource userLocalDataSource =
    UserLocalDataSourceImpl(database);

final UserRepository userRepository = UserRepositoryImpl(userLocalDataSource);

final FindAllUserUseCase findAllUserUseCase =
    FindAllUserUseCase(userRepository);
final CreateUserUseCase createUserUseCase = CreateUserUseCase(userRepository);
final FindByIdUserUseCase findByIdUserUseCase =
    FindByIdUserUseCase(userRepository);
final UpdateStatusUserUseCase updateStatusUserUseCase =
    UpdateStatusUserUseCase(userRepository);
final UpdateUserUseCase updateUserUseCase = UpdateUserUseCase(userRepository);
final LoginUseCase loginUseCase = LoginUseCase(userRepository);
final ChangePasswordUseCase changePasswordUseCase =
    ChangePasswordUseCase(userRepository);
