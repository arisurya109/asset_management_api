// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/container/data/model/container_model.dart';

abstract class ContainerLocalDataSource {
  Future<ContainerModel> createContainer(ContainerModel params);
  Future<ContainerModel> updateContainer(ContainerModel params);
  Future<List<ContainerModel>> findAllContainer();
}
