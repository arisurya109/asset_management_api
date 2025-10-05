// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/module_permission/domain/entities/module_permission.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ModulePermissionModel extends Equatable {
  int? id;
  String? modulePermissionName;
  String? modulePermissionLabel;

  ModulePermissionModel({
    this.id,
    this.modulePermissionName,
    this.modulePermissionLabel,
  });

  factory ModulePermissionModel.fromDatabase(Map<String, dynamic> map) {
    return ModulePermissionModel(
      id: map['id'] != null ? map['id'] as int : null,
      modulePermissionName: map['module_permission_name'] != null
          ? map['module_permission_name'] as String
          : null,
      modulePermissionLabel: map['module_permission_label'] != null
          ? map['module_permission_label'] as String
          : null,
    );
  }

  ModulePermission toEntity() {
    return ModulePermission(
      id: id,
      modulePermissionLabel: modulePermissionLabel,
      modulePermissionName: modulePermissionName,
    );
  }

  @override
  List<Object?> get props => [id, modulePermissionName, modulePermissionLabel];
}
