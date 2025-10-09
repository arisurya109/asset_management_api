// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/container_detail/data/model/container_detail_model.dart';

abstract class ContainerDetailLocalDataSource {
  Future<ContainerDetailModel> createContainerDetail(
    ContainerDetailModel params,
  );
  Future<ContainerDetailModel> updateContainerDetail(
    ContainerDetailModel params,
  );
  Future<List<ContainerDetailModel>> findAllContainerDetail();
}
