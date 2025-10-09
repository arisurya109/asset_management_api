// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/areas/area_export.dart';
import 'package:asset_management_api/features/asset_types/asset_type_export.dart';
import 'package:asset_management_api/features/brands/brand_export.dart';
import 'package:asset_management_api/features/categories/category_export.dart';
import 'package:asset_management_api/features/container/container_export.dart';
import 'package:asset_management_api/features/container_detail/container_detail_export.dart';
import 'package:asset_management_api/features/location_detail/location_detail_export.dart';
import 'package:asset_management_api/features/locations/location_export.dart';
import 'package:asset_management_api/features/module_permission/module_permission_export.dart';
import 'package:asset_management_api/features/users/user_export.dart';

final Database database = Database();
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

// Categories
final CategoryLocalDataSource categoryLocalDataSource =
    CategoryLocalDataSourceImpl(database);
final CategoryRepository categoryRepository =
    CategoryRepositoryImpl(categoryLocalDataSource);
final CreateCategoryUseCase createCategoryUseCase =
    CreateCategoryUseCase(categoryRepository);
final FindAllCategoryUseCase findAllCategoryUseCase =
    FindAllCategoryUseCase(categoryRepository);
final UpdateCategoryUseCase updateCategoryUseCase =
    UpdateCategoryUseCase(categoryRepository);
final FindCategoryByIdUseCase findCategoryByIdUseCase =
    FindCategoryByIdUseCase(categoryRepository);

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

// Module Permission
final ModulePermissionLocalDataSource modulePermissionLocalDataSource =
    ModulePermissionLocalDataSourceImpl(database);
final ModulePermissionRepository modulePermissionRepository =
    ModulePermissionRepositoryImpl(modulePermissionLocalDataSource);
final FindAllModulePermissionUseCase findAllModulePermissionUseCase =
    FindAllModulePermissionUseCase(modulePermissionRepository);
final FindModulePermissionByIdUseCase findModulePermissionByIdUseCase =
    FindModulePermissionByIdUseCase(modulePermissionRepository);

// Area
final AreaLocalDataSource areaLocalDataSource =
    AreaLocalDataSourceImpl(database);
final AreaRepository areaRepository = AreaRepositoryImpl(areaLocalDataSource);
final FindAllAreaUseCase findAllAreaUseCase =
    FindAllAreaUseCase(areaRepository);
final FindAreaByIdUseCase findAreaByIdUseCase =
    FindAreaByIdUseCase(areaRepository);

// Location
final LocationLocalDataSource locationLocalDataSource =
    LocationLocalDataSourceImpl(database);
final LocationRespository locationRespository =
    LocationRepositoryImpl(locationLocalDataSource);
final FindAllLocationUseCase findAllLocationUseCase =
    FindAllLocationUseCase(locationRespository);
final FindLocationByIdUseCase findLocationByIdUseCase =
    FindLocationByIdUseCase(locationRespository);
final CreateLocationUseCase createLocationUseCase =
    CreateLocationUseCase(locationRespository);
final UpdateLocationUseCase updateLocationUseCase =
    UpdateLocationUseCase(locationRespository);

// Location Detail
final LocationDetailLocalDataSource locationDetailLocalDataSource =
    LocationDetailLocalDataSourceImpl(database);
final LocationDetailRepository locationDetailRepository =
    LocationDetailRepositoryImpl(locationDetailLocalDataSource);
final FindAllLocationDetailUseCase findAllLocationDetailUseCase =
    FindAllLocationDetailUseCase(locationDetailRepository);
final UpdateLocationDetalUseCase updateLocationDetalUseCase =
    UpdateLocationDetalUseCase(locationDetailRepository);
final CreateLocationDetailUseCase createLocationDetailUseCase =
    CreateLocationDetailUseCase(locationDetailRepository);

// Container
final ContainerLocalDataSource containerLocalDataSource =
    ContainerLocalDataSourceImpl(database);
final ContainerRepository containerRepository =
    ContainerRepositoryImpl(containerLocalDataSource);
final FindAllContainerUseCase findAllContainerUseCase =
    FindAllContainerUseCase(containerRepository);
final CreateContainerUseCase createContainerUseCase =
    CreateContainerUseCase(containerRepository);
final UpdateContainerUseCase updateContainerUseCase =
    UpdateContainerUseCase(containerRepository);

// Container Detail
final ContainerDetailLocalDataSource containerDetailLocalDataSource =
    ContainerDetailLocalDataSourceImpl(database);
final ContainerDetailRepository containerDetailRepository =
    ContainerDetailRepositoryImpl(containerDetailLocalDataSource);
final FindAllContainerDetailUseCase findAllContainerDetailUseCase =
    FindAllContainerDetailUseCase(containerDetailRepository);
final CreateContainerDetailUseCase createContainerDetailUseCase =
    CreateContainerDetailUseCase(containerDetailRepository);
final UpdateContainerDetailUseCase updateContainerDetailUseCase =
    UpdateContainerDetailUseCase(containerDetailRepository);
