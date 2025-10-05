// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_types/asset_type_export.dart';
import 'package:asset_management_api/features/assets/asset_export.dart';
import 'package:asset_management_api/features/brands/brand_export.dart';
import 'package:asset_management_api/features/module_permission/module_permission_export.dart';
import 'package:asset_management_api/features/users/user_export.dart';

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

// Asset
final AssetLocalDataSource assetLocalDataSource =
    AssetLocalDataSourceImpl(database);
final AssetRepository assetRepository =
    AssetRepositoryImpl(assetLocalDataSource);
final CreateAssetUseCase createAssetUseCase =
    CreateAssetUseCase(assetRepository);
final FindAllAssetUseCase findAllAssetUseCase =
    FindAllAssetUseCase(assetRepository);
final UpdateAssetUseCase updateAssetUseCase =
    UpdateAssetUseCase(assetRepository);
final FindAssetByIdUseCase findAssetByIdUseCase =
    FindAssetByIdUseCase(assetRepository);

// Brand
final BrandLocalDataSource brandLocalDataSource =
    BrandLocalDataSourceImpl(database);
final BrandRepository brandRepository =
    BrandRepositoryImpl(brandLocalDataSource);
final FindAllBrandUseCase findAllBrandUseCase =
    FindAllBrandUseCase(brandRepository);
final CreateBrandUseCase createBrandUseCase =
    CreateBrandUseCase(brandRepository);
final FindBrandByIdUseCase findBrandByIdUseCase =
    FindBrandByIdUseCase(brandRepository);
final FindBrandByIdAssetUseCase findBrandByIdAssetUseCase =
    FindBrandByIdAssetUseCase(brandRepository);
final UpdateBrandUseCase updateBrandUseCase =
    UpdateBrandUseCase(brandRepository);

// Asset Type
final AssetTypeLocalDataSource assetTypeLocalDataSource =
    AssetTypeLocalDataSourceImpl(database);
final AssetTypeRepository assetTypeRepository =
    AssetTypeRepositoryImpl(assetTypeLocalDataSource);
final CreateAssetTypeUseCase createAssetTypeUseCase =
    CreateAssetTypeUseCase(assetTypeRepository);
final FindAllAssetTypeUseCase findAllAssetTypeUseCase =
    FindAllAssetTypeUseCase(assetTypeRepository);
final FindAssetTypeByIdUseCase findAssetTypeByIdUseCase =
    FindAssetTypeByIdUseCase(assetTypeRepository);
final FindAssetTypeByIdBrandUseCase findAssetTypeByIdBrandUseCase =
    FindAssetTypeByIdBrandUseCase(assetTypeRepository);
final UpdateAssetTypeUseCase updateAssetTypeUseCase =
    UpdateAssetTypeUseCase(assetTypeRepository);

final ModulePermissionLocalDataSource modulePermissionLocalDataSource =
    ModulePermissionLocalDataSourceImpl(database);
final ModulePermissionRepository modulePermissionRepository =
    ModulePermissionRepositoryImpl(modulePermissionLocalDataSource);
final FindAllModulePermissionUseCase findAllModulePermissionUseCase =
    FindAllModulePermissionUseCase(modulePermissionRepository);
final FindModulePermissionByIdUseCase findModulePermissionByIdUseCase =
    FindModulePermissionByIdUseCase(modulePermissionRepository);
