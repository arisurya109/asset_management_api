// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_brand/asset_brand_export.dart';
import 'package:asset_management_api/features/asset_brand/domain/usecases/find_asset_brand_by_query_use_case.dart';
import 'package:asset_management_api/features/asset_categories/asset_category_export.dart';
import 'package:asset_management_api/features/asset_categories/domain/usecases/find_asset_category_by_query_use_case.dart';
import 'package:asset_management_api/features/asset_models/asset_model_export.dart';
import 'package:asset_management_api/features/asset_models/domain/usecases/find_asset_model_by_query_use_case.dart';

import 'package:asset_management_api/features/asset_type/asset_type_export.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_by_pagination_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_by_query_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_detail_by_id_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/migration_asset_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/registration_asset_use_case.dart';
import 'package:asset_management_api/features/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:asset_management_api/features/inventory/data/source/inventory_local_data_source.dart';
import 'package:asset_management_api/features/inventory/data/source/inventory_local_data_source_impl.dart';
import 'package:asset_management_api/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:asset_management_api/features/inventory/domain/usecases/find_inventory_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/delete_location_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_all_location_type_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_by_pagination_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_by_query_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_non_storage_use_case.dart';
import 'package:asset_management_api/features/location/domain/usecases/find_location_storage_use_case.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:asset_management_api/features/module_permission/module_permission_export.dart';
import 'package:asset_management_api/features/movement/data/repositories/movement_repository_impl.dart';
import 'package:asset_management_api/features/movement/data/source/movement_local_data_source.dart';
import 'package:asset_management_api/features/movement/data/source/movement_local_data_source_impl.dart';
import 'package:asset_management_api/features/movement/domain/repositories/movement_repository.dart';
import 'package:asset_management_api/features/movement/domain/usecases/create_movement_use_case.dart';
import 'package:asset_management_api/features/picking/data/repositories/picking_repository_impl.dart';
import 'package:asset_management_api/features/picking/data/source/picking_local_data_source.dart';
import 'package:asset_management_api/features/picking/data/source/picking_local_data_source_impl.dart';
import 'package:asset_management_api/features/picking/domain/repositories/picking_repository.dart';
import 'package:asset_management_api/features/picking/domain/usecases/find_all_picking_task_use_case.dart';
import 'package:asset_management_api/features/picking/domain/usecases/find_picking_detail_use_case.dart';
import 'package:asset_management_api/features/picking/domain/usecases/picked_asset_use_case.dart';
import 'package:asset_management_api/features/preparation/data/repositories/preparation_repository_impl.dart';
import 'package:asset_management_api/features/preparation/data/repositories/prepartion_detail_repository_impl.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_detail_local_data_source.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_detail_local_data_source_impl.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source_impl.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_detail_repository.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/add_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_pagination_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/get_preparation_details_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/get_preparation_types_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_preparation_status_use_case.dart';
import 'package:asset_management_api/features/preparation_item/data/repositories/preparation_item_repository_impl.dart';
import 'package:asset_management_api/features/preparation_item/data/source/preparation_item_local_data_source.dart';
import 'package:asset_management_api/features/preparation_item/data/source/preparation_item_local_data_source_impl.dart';
import 'package:asset_management_api/features/preparation_item/domain/repositories/preparation_item_repository.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/create_preparation_item_use_case.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/delete_preparation_item_use_case.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/find_all_preparation_item_by_preparation_detail_id_use_case.dart';
import 'package:asset_management_api/features/preparation_item/domain/usecases/find_all_preparation_item_by_preparation_id_use_case.dart';
import 'package:asset_management_api/features/preparation_template/data/repositories/preparation_template_repository_impl.dart';
import 'package:asset_management_api/features/preparation_template/data/source/preparation_template_local_data_source.dart';
import 'package:asset_management_api/features/preparation_template/data/source/preparation_template_local_data_source_impl.dart';
import 'package:asset_management_api/features/preparation_template/domain/repositories/preparation_template_repository.dart';
import 'package:asset_management_api/features/preparation_template/domain/usecases/create_preparation_template_item_use_case.dart';
import 'package:asset_management_api/features/preparation_template/domain/usecases/create_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation_template/domain/usecases/find_all_preparation_template_item_by_template_id_use_case.dart';
import 'package:asset_management_api/features/preparation_template/domain/usecases/find_all_preparation_template_use_case.dart';
import 'package:asset_management_api/features/purchase_order/purchase_order_export.dart';
import 'package:asset_management_api/features/reprint/data/repositories/reprint_repository_impl.dart';
import 'package:asset_management_api/features/reprint/data/source/reprint_local_data_source.dart';
import 'package:asset_management_api/features/reprint/data/source/reprint_local_data_source_impl.dart';
import 'package:asset_management_api/features/reprint/domain/repositories/reprint_repository.dart';
import 'package:asset_management_api/features/reprint/domain/usecases/reprint_asset_use_case.dart';
import 'package:asset_management_api/features/reprint/domain/usecases/reprint_location_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/auto_login_use_case.dart';
import 'package:asset_management_api/features/users/domain/usecases/delete_user_use_case.dart';
import 'package:asset_management_api/features/users/user_export.dart';
import 'package:asset_management_api/features/vendor/vendor_export.dart';

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
final DeleteUserUseCase deleteUserUseCase = DeleteUserUseCase(userRepository);
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
final FindAssetCategoryByQueryUseCase findAssetCategoryByQueryUseCase =
    FindAssetCategoryByQueryUseCase(assetCategoryRepository);

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
final FindAssetBrandByQueryUseCase findAssetBrandByQueryUseCase =
    FindAssetBrandByQueryUseCase(assetBrandRepository);

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
final FindAssetModelByQueryUseCase findAssetModelByQueryUseCase =
    FindAssetModelByQueryUseCase(assetModelRepository);

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
final FindLocationByQueryUseCase findLocationByQueryUseCase =
    FindLocationByQueryUseCase(locationRepository);
final FindLocationStorageUseCase findLocationStorageUseCase =
    FindLocationStorageUseCase(locationRepository);
final FindLocationNonStorageUseCase findLocationNonStorageUseCase =
    FindLocationNonStorageUseCase(locationRepository);
final FindAllLocationTypeUseCase findAllLocationTypeUseCase =
    FindAllLocationTypeUseCase(locationRepository);
final DeleteLocationUseCase deleteLocationUseCase =
    DeleteLocationUseCase(locationRepository);
final FindLocationByPaginationUseCase findLocationByPaginationUseCase =
    FindLocationByPaginationUseCase(locationRepository);

// Assets
final AssetsLocalDataSource assetsLocalDataSource =
    AssetsLocalDataSourceImpl(database, databaseErpOld);
final AssetsRepository assetsRepository =
    AssetsRepositoryImpl(assetsLocalDataSource);
final FindAllAssetsUseCase findAllAssetsUseCase =
    FindAllAssetsUseCase(assetsRepository);
final MigrationAssetUseCase migrationAssetUseCase =
    MigrationAssetUseCase(assetsRepository);
final RegistrationAssetUseCase registrationAssetUseCase =
    RegistrationAssetUseCase(assetsRepository);
final FindAssetDetailByIdUseCase findAssetDetailByIdUseCase =
    FindAssetDetailByIdUseCase(assetsRepository);
final FindAssetByQueryUseCase findAssetByQueryUseCase =
    FindAssetByQueryUseCase(assetsRepository);
final FindAssetByPaginationUseCase findAssetByPaginationUseCase =
    FindAssetByPaginationUseCase(assetsRepository);

// Vendors
final VendorLocalDataSource vendorLocalDataSource =
    VendorLocalDataSourceImpl(database);
final VendorRepository vendorRepository =
    VendorRepositoryImpl(vendorLocalDataSource);
final CreateVendorUseCase createVendorUseCase =
    CreateVendorUseCase(vendorRepository);
final UpdateVendorUseCase updateVendorUseCase =
    UpdateVendorUseCase(vendorRepository);
final FindAllVendorUseCase findAllVendorUseCase =
    FindAllVendorUseCase(vendorRepository);

// Purchase Order
final PurchaseOrderLocalDataSource purchaseOrderLocalDataSource =
    PurchaseOrderLocalDataSourceImpl(database);
final PurchaseOrderRepository purchaseOrderRepository =
    PurchaseOrderRepositoryImpl(purchaseOrderLocalDataSource);
final CreatePurchaseOrderUseCase createPurchaseOrderUseCase =
    CreatePurchaseOrderUseCase(purchaseOrderRepository);
final FindAllPurchaseOrderUseCase findAllPurchaseOrderUseCase =
    FindAllPurchaseOrderUseCase(purchaseOrderRepository);
final FindPurchaseOrderDetailItemUseCase findPurchaseOrderDetailItemUseCase =
    FindPurchaseOrderDetailItemUseCase(purchaseOrderRepository);
final UpdatePurchaseOrderUseCase updatePurchaseOrderUseCase =
    UpdatePurchaseOrderUseCase(purchaseOrderRepository);

// Preparation Item
final PreparationItemLocalDataSource preparationItemLocalDataSource =
    PreparationItemLocalDataSourceImpl(database);
final PreparationItemRepository preparationItemRepository =
    PreparationItemRepositoryImpl(preparationItemLocalDataSource);
final CreatePreparationItemUseCase createPreparationItemUseCase =
    CreatePreparationItemUseCase(preparationItemRepository);
final DeletePreparationItemUseCase deletePreparationItemUseCase =
    DeletePreparationItemUseCase(preparationItemRepository);
final FindAllPreparationItemByPreparationDetailIdUseCase
    findAllPreparationItemByPreparationDetailIdUseCase =
    FindAllPreparationItemByPreparationDetailIdUseCase(
  preparationItemRepository,
);
final FindAllPreparationItemByPreparationIdUseCase
    findAllPreparationItemByPreparationIdUseCase =
    FindAllPreparationItemByPreparationIdUseCase(preparationItemRepository);

// Preparation Template
final PreparationTemplateLocalDataSource preparationTemplateLocalDataSource =
    PreparationTemplateLocalDataSourceImpl(database);
final PreparationTemplateRepository preparationTemplateRepository =
    PreparationTemplateRepositoryImpl(preparationTemplateLocalDataSource);
final CreatePreparationTemplateUseCase createPreparationTemplateUseCase =
    CreatePreparationTemplateUseCase(preparationTemplateRepository);
final CreatePreparationTemplateItemUseCase
    createPreparationTemplateItemUseCase =
    CreatePreparationTemplateItemUseCase(preparationTemplateRepository);
final FindAllPreparationTemplateUseCase findAllPreparationTemplateUseCase =
    FindAllPreparationTemplateUseCase(preparationTemplateRepository);
final FindAllPreparationTemplateItemByTemplateIdUseCase
    findAllPreparationTemplateItemByTemplateIdUseCase =
    FindAllPreparationTemplateItemByTemplateIdUseCase(
  preparationTemplateRepository,
);

// Reprint
final ReprintLocalDataSource reprintLocalDataSource =
    ReprintLocalDataSourceImpl(database);
final ReprintRepository reprintRepository =
    ReprintRepositoryImpl(reprintLocalDataSource);
final ReprintAssetUseCase reprintAssetUseCase =
    ReprintAssetUseCase(reprintRepository);
final ReprintLocationUseCase reprintLocationUseCase =
    ReprintLocationUseCase(reprintRepository);

final InventoryLocalDataSource inventoryLocalDataSource =
    InventoryLocalDataSourceImpl(database);
final InventoryRepository inventoryRepository =
    InventoryRepositoryImpl(inventoryLocalDataSource);
final FindInventoryUseCase findInventoryUseCase =
    FindInventoryUseCase(inventoryRepository);

// Movement
final MovementLocalDataSource movementLocalDataSource =
    MovementLocalDataSourceImpl(database);
final MovementRepository movementRepository =
    MovementRepositoryImpl(movementLocalDataSource);
final CreateMovementUseCase createMovementUseCase =
    CreateMovementUseCase(movementRepository);

// Preparation
final PreparationLocalDataSource preparationLocalDataSource =
    PreparationLocalDataSourceImpl(database);
final PreparationDetailLocalDataSource preparationDetailLocalDataSource =
    PreparationDetailLocalDataSourceImpl(database);
final PreparationRepository preparationRepository =
    PreparationRepositoryImpl(preparationLocalDataSource);
final PreparationDetailRepository preparationDetailRepository =
    PreparationDetailRepositoryImpl(preparationDetailLocalDataSource);
final CreatePreparationUseCase createPreparationUseCase =
    CreatePreparationUseCase(preparationRepository);
final FindPreparationByPaginationUseCase findPreparationByPaginationUseCase =
    FindPreparationByPaginationUseCase(preparationRepository);
final UpdatePreparationStatusUseCase updatePreparationStatusUseCase =
    UpdatePreparationStatusUseCase(preparationRepository);
final GetPreparationTypesUseCase getPreparationTypesUseCase =
    GetPreparationTypesUseCase(preparationRepository);
final GetPreparationDetailsUseCase getPreparationDetailsUseCase =
    GetPreparationDetailsUseCase(preparationDetailRepository);
final AddPreparationDetailUseCase addPreparationDetailUseCase =
    AddPreparationDetailUseCase(preparationDetailRepository);

final PickingLocalDataSource pickingLocalDataSource =
    PickingLocalDataSourceImpl(database);
final PickingRepository pickingRepository =
    PickingRepositoryImpl(pickingLocalDataSource);
final FindAllPickingTaskUseCase findAllPickingTaskUseCase =
    FindAllPickingTaskUseCase(pickingRepository);
final FindPickingDetailUseCase findPickingDetailUseCase =
    FindPickingDetailUseCase(pickingRepository);
final PickedAssetUseCase pickedAssetUseCase =
    PickedAssetUseCase(pickingRepository);
