// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

/// Entity untuk item permission individual
class PermissionItem extends Equatable {
  const PermissionItem({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

class ModulePermission extends Equatable {
  const ModulePermission({
    required this.module,
    required this.permissions,
  });
  final String module;
  final List<PermissionItem> permissions;

  /// Digunakan untuk mengonversi ke Map jika dibutuhkan oleh API/Response
  Map<String, dynamic> toResponse() {
    return {
      'module': module,
      'permissions': permissions
          .map(
            (p) => {
              'id': p.id,
              'name': p.name,
            },
          )
          .toList(),
    };
  }

  @override
  List<Object?> get props => [module, permissions];
}
