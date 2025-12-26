// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls

import 'package:asset_management_api/features/module_permission/domain/entities/module_permission.dart';
import 'package:equatable/equatable.dart';

class PermissionItemModel extends Equatable {
  const PermissionItemModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  PermissionItem toEntity() {
    return PermissionItem(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class ModulePermissionModel extends Equatable {
  const ModulePermissionModel({
    required this.module,
    required this.permissions,
  });
  final String module;
  final List<PermissionItemModel> permissions;

  ModulePermission toEntity() {
    return ModulePermission(
      module: module,
      permissions: permissions.map((p) => p.toEntity()).toList(),
    );
  }

  factory ModulePermissionModel.fromGroupedMap(
    String moduleName,
    List<Map<String, dynamic>> permissionsList,
  ) {
    return ModulePermissionModel(
      module: moduleName,
      permissions: permissionsList
          .map(
            (p) => PermissionItemModel(
              id: p['id'] as int,
              name: p['name'] as String,
            ),
          )
          .toList(),
    );
  }

  static List<ModulePermissionModel> transformFromDatabase(
    List<dynamic> queryResult,
  ) {
    final grouped = <String, List<Map<String, dynamic>>>{};

    for (final row in queryResult) {
      final data = row as Map<String, dynamic>;
      final moduleName = data['module'].toString();

      if (!grouped.containsKey(moduleName)) {
        grouped[moduleName] = [];
      }

      grouped[moduleName]!.add({
        'id': data['id'],
        'name': data['permission'],
      });
    }

    return grouped.entries.map((entry) {
      return ModulePermissionModel.fromGroupedMap(entry.key, entry.value);
    }).toList();
  }

  @override
  List<Object?> get props => [module, permissions];
}
