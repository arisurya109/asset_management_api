// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/core/config/database.dart';
import 'package:asset_management_api/core/services/jwt.dart';
import 'package:asset_management_api/features/asset_brand/asset_brand_export.dart';
import 'package:asset_management_api/features/asset_categories/asset_category_export.dart';
import 'package:asset_management_api/features/asset_models/asset_model_export.dart';

import 'package:asset_management_api/features/asset_type/asset_type_export.dart';
import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/assets/domain/usecases/create_asset_transfer_use_case.dart';
import 'package:asset_management_api/features/assets/domain/usecases/find_asset_detail_by_id_use_case.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:asset_management_api/features/module_permission/module_permission_export.dart';
import 'package:asset_management_api/features/preparation/data/repositories/preparation_repository_impl.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source.dart';
import 'package:asset_management_api/features/preparation/data/source/preparation_local_data_source_impl.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/completed_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_item_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_template_item_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/create_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/delete_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/dispatch_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_detail_by_preparation_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_item_by_preparation_detail_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_item_by_preparation_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_template_item_by_template_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_template_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_all_preparation_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_document_preparation_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/find_preparation_detail_by_id_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_preparation_detail_use_case.dart';
import 'package:asset_management_api/features/preparation/domain/usecases/update_preparation_use_case.dart';
import 'package:asset_management_api/features/purchase_order/purchase_order_export.dart';
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

// Assets
final AssetsLocalDataSource assetsLocalDataSource =
    AssetsLocalDataSourceImpl(database, databaseErpOld);
final AssetsRepository assetsRepository =
    AssetsRepositoryImpl(assetsLocalDataSource);
final FindAllAssetsUseCase findAllAssetsUseCase =
    FindAllAssetsUseCase(assetsRepository);
final CreateAssetsUseCase createAssetsUseCase =
    CreateAssetsUseCase(assetsRepository);
final FindAssetDetailByIdUseCase findAssetDetailByIdUseCase =
    FindAssetDetailByIdUseCase(assetsRepository);
final CreateAssetTransferUseCase createAssetTransferUseCase =
    CreateAssetTransferUseCase(assetsRepository);

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

// Preparation
final PreparationLocalDataSource preparationLocalDataSource =
    PreparationLocalDataSourceImpl(database);
final PreparationRepository preparationRepository =
    PreparationRepositoryImpl(preparationLocalDataSource);
final CreatePreparationTemplateUseCase createPreparationTemplateUseCase =
    CreatePreparationTemplateUseCase(preparationRepository);
final CreatePreparationTemplateItemUseCase
    createPreparationTemplateItemUseCase =
    CreatePreparationTemplateItemUseCase(preparationRepository);
final DeletePreparationTemplateUseCase deletePreparationTemplateUseCase =
    DeletePreparationTemplateUseCase(preparationRepository);
final FindAllPreparationTemplateUseCase findAllPreparationTemplateUseCase =
    FindAllPreparationTemplateUseCase(preparationRepository);
final FindAllPreparationTemplateItemByTemplateIdUseCase
    findAllPreparationTemplateItemByTemplateIdUseCase =
    FindAllPreparationTemplateItemByTemplateIdUseCase(preparationRepository);
final FindAllPreparationUseCase findAllPreparationUseCase =
    FindAllPreparationUseCase(preparationRepository);
final DispatchPreparationUseCase dispatchPreparationUseCase =
    DispatchPreparationUseCase(preparationRepository);
final CompletedPreparationUseCase completedPreparationUseCase =
    CompletedPreparationUseCase(preparationRepository);
final FindDocumentPreparationByIdUseCase findDocumentPreparationByIdUseCase =
    FindDocumentPreparationByIdUseCase(preparationRepository);
final FindPreparationByIdUseCase findPreparationByIdUseCase =
    FindPreparationByIdUseCase(preparationRepository);
final CreatePreparationUseCase createPreparationUseCase =
    CreatePreparationUseCase(preparationRepository);
final UpdatePreparationUseCase updatePreparationUseCase =
    UpdatePreparationUseCase(preparationRepository);
final CreatePreparationDetailUseCase createPreparationDetailUseCase =
    CreatePreparationDetailUseCase(preparationRepository);
final FindAllPreparationDetailByPreparationIdUseCase
    findAllPreparationDetailByPreparationIdUseCase =
    FindAllPreparationDetailByPreparationIdUseCase(preparationRepository);
final FindPreparationDetailByIdUseCase findPreparationDetailByIdUseCase =
    FindPreparationDetailByIdUseCase(preparationRepository);
final UpdatePreparationDetailUseCase updatePreparationDetailUseCase =
    UpdatePreparationDetailUseCase(preparationRepository);
final CreatePreparationItemUseCase createPreparationItemUseCase =
    CreatePreparationItemUseCase(preparationRepository);
final FindAllPreparationItemByPreparationDetailId
    findAllPreparationItemByPreparationDetailId =
    FindAllPreparationItemByPreparationDetailId(preparationRepository);
final FindAllPreparationItemByPreparationId
    findAllPreparationItemByPreparationId =
    FindAllPreparationItemByPreparationId(preparationRepository);
