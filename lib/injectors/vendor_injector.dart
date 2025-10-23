// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/vendor/vendor_export.dart';
import 'package:asset_management_api/injectors/injector_behavior.dart';
import 'package:dart_frog/dart_frog.dart';

Handler vendorInjector(Handler handler) {
  return handler
      .use(provider<CreateVendorUseCase>((_) => createVendorUseCase))
      .use(provider<UpdateVendorUseCase>((_) => updateVendorUseCase))
      .use(provider<FindAllVendorUseCase>((_) => findAllVendorUseCase));
}
