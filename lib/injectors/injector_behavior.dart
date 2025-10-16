// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_brand/asset_brand_export.dart';
import 'package:asset_management_api/features/asset_categories/asset_category_export.dart';
import 'package:asset_management_api/features/asset_migration/asset_migration_export.dart';
import 'package:asset_management_api/features/asset_models/asset_model_export.dart';
import 'package:asset_management_api/features/asset_transfer/asset_transfer_export.dart';

import 'package:asset_management_api/features/asset_type/asset_type_export.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:asset_management_api/features/module_permission/module_permission_export.dart';
import 'package:asset_management_api/features/users/domain/usecases/auto_login_use_case.dart';
import 'package:asset_management_api/features/users/user_export.dart';

final Database database = Database();
final DatabaseErpOld databaseErpOld = DatabaseErpOld();
final JwtService jwtService = JwtServiceImpl(database);

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
final AutoLoginUseCase autoLoginUseCase = AutoLoginUseCase(userRepository);

// Module Permission
final ModulePermissionLocalDataSource modulePermissionLocalDataSource =
    ModulePermissionLocalDataSourceImpl(database);
final ModulePermissionRepository modulePermissionRepository =
    ModulePermissionRepositoryImpl(modulePermissionLocalDataSource);
final FindAllModulePermissionUseCase findAllModulePermissionUseCase =
    FindAllModulePermissionUseCase(modulePermissionRepository);
final FindModulePermissionByIdUseCase findModulePermissionByIdUseCase =
    FindModulePermissionByIdUseCase(modulePermissionRepository);

// Asset Type
final AssetTypeLocalDataSource assetTypeLocalDataSource =
    AssetTypeLocalDataSourceImpl(database);
final AssetTypeRepository assetTypeRepository =
    AssetTypeRepositoryImpl(assetTypeLocalDataSource);
final CreateAssetTypeUseCase createAssetTypeUseCase =
    CreateAssetTypeUseCase(assetTypeRepository);
final FindAllAssetTypeUseCase findAllAssetTypeUseCase =
    FindAllAssetTypeUseCase(assetTypeRepository);
final UpdateAssetTypeUseCase updateAssetTypeUseCase =
    UpdateAssetTypeUseCase(assetTypeRepository);
final FindByIdAssetTypeUseCase findByIdAssetTypeUseCase =
    FindByIdAssetTypeUseCase(assetTypeRepository);

// Asset Category
final AssetCategoryLocalDataSource assetCategoryLocalDataSource =
    AssetCategoryLocalDataSourceImpl(database);
final AssetCategoryRepository assetCategoryRepository =
    AssetCategoryRepositoryImpl(assetCategoryLocalDataSource);
final CreateAssetCategoryUseCase createAssetCategoryUseCase =
    CreateAssetCategoryUseCase(assetCategoryRepository);
final FindAllAssetCategoryUseCase findAllAssetCategoryUseCase =
    FindAllAssetCategoryUseCase(assetCategoryRepository);
final UpdateAssetCategoryUseCase updateAssetCategoryUseCase =
    UpdateAssetCategoryUseCase(assetCategoryRepository);
final FindByIdAssetCategoryUseCase findByIdAssetCategoryUseCase =
    FindByIdAssetCategoryUseCase(assetCategoryRepository);

// Asset Brand
final AssetBrandLocalDataSource assetBrandLocalDataSource =
    AssetBrandLocalDataSourceImpl(database);
final AssetBrandRepository assetBrandRepository =
    AssetBrandRepositoryImpl(assetBrandLocalDataSource);
final FindAllAssetBrandUseCase findAllAssetBrandUseCase =
    FindAllAssetBrandUseCase(assetBrandRepository);
final FindByIdAssetBrandUseCase findByIdAssetBrandUseCase =
    FindByIdAssetBrandUseCase(assetBrandRepository);
final CreateAssetBrandUseCase createAssetBrandUseCase =
    CreateAssetBrandUseCase(assetBrandRepository);
final UpdateAssetBrandUseCase updateAssetBrandUseCase =
    UpdateAssetBrandUseCase(assetBrandRepository);

// Asset Model
final AssetModelLocalDataSource assetModelLocalDataSource =
    AssetModelLocalDataSourceImpl(database);
final AssetModelRepository assetModelRepository =
    AssetModelRepositoryImpl(assetModelLocalDataSource);
final FindAllAssetModelUseCase findAllAssetModelUseCase =
    FindAllAssetModelUseCase(assetModelRepository);
final FindByIdAssetModelUseCase findByIdAssetModelUseCase =
    FindByIdAssetModelUseCase(assetModelRepository);
final CreateAssetModelUseCase createAssetModelUseCase =
    CreateAssetModelUseCase(assetModelRepository);
final UpdateAssetModelUseCase updateAssetModelUseCase =
    UpdateAssetModelUseCase(assetModelRepository);

// Location
final LocationLocalDataSource locationLocalDataSource =
    LocationLocalDataSourceImpl(database);
final LocationRepository locationRepository =
    LocationRepositoryImpl(locationLocalDataSource);
final CreateLocationUseCase createLocationUseCase =
    CreateLocationUseCase(locationRepository);
final FindAllLocationUseCase findAllocationUseCase =
    FindAllLocationUseCase(locationRepository);
final FindByIdLocationUseCase findByIdocationUseCase =
    FindByIdLocationUseCase(locationRepository);
final UpdateLocationUseCase updateocationUseCase =
    UpdateLocationUseCase(locationRepository);

// Asset Migration
final AssetMigrationLocalDataSource assetMigrationLocalDataSource =
    AssetMigrationLocalDataSourceImpl(database, databaseErpOld);
final AssetMigrationRepository assetMigrationRepository =
    AssetMigrationRepositoryImpl(assetMigrationLocalDataSource);
final CreateAssetConsumableUseCase createAssetConsumableUseCase =
    CreateAssetConsumableUseCase(assetMigrationRepository);
final CreateNewAssetUseCase createNewAssetUseCase =
    CreateNewAssetUseCase(assetMigrationRepository);
final FindAllAssetMigrationUseCase findAllAssetMigrationUseCase =
    FindAllAssetMigrationUseCase(assetMigrationRepository);
final MigrationAssetUseCase migrationAssetUseCase =
    MigrationAssetUseCase(assetMigrationRepository);

// Asset Transfer
final AssetTransferLocalDataSource assetTransferLocalDataSource =
    AssetTransferLocalDataSourceImpl(database);
final AssetTransferRepository assetTransferRepository =
    AssetTransferRepositoryImpl(assetTransferLocalDataSource);
final CreateAssetTransferUseCase createAssetTransferUseCase =
    CreateAssetTransferUseCase(assetTransferRepository);

// Asstes
final AssetsLocalDataSource assetsLocalDataSource =
    AssetsLocalDataSourceImpl(database);
final AssetsRepository assetsRepository =
    AssetsRepositoryImpl(assetsLocalDataSource);
final FindAllAssetsUseCase findAllAssetsUseCase =
    FindAllAssetsUseCase(assetsRepository);
