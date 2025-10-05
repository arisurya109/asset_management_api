// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ModulePermission extends Equatable {
  int? id;
  String? modulePermissionName;
  String? modulePermissionLabel;

  ModulePermission({
    this.id,
    this.modulePermissionName,
    this.modulePermissionLabel,
  });

  Map<String, dynamic> toResponse() {
    return <String, dynamic>{
      'id': id,
      'module_permission_name': modulePermissionName,
      'module_permission_label': modulePermissionLabel,
    };
  }

  @override
  List<Object?> get props => [id, modulePermissionName, modulePermissionLabel];
}
