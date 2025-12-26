// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management_api/features/users/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  int? id;
  String? username;
  String? password;
  String? name;
  int? isActive;
  DateTime? createdAt;
  String? createdBy;
  List<Map<String, dynamic>>? modules;

  UserModel({
    this.id,
    this.username,
    this.password,
    this.name,
    this.isActive,
    this.createdAt,
    this.createdBy,
    this.modules,
  });

  @override
  List<Object?> get props {
    return [
      id,
      username,
      password,
      name,
      isActive,
      createdAt,
      createdBy,
      modules,
    ];
  }

  User toEntity() {
    return User(
      id: id,
      username: username,
      name: name,
      password: password,
      isActive: isActive,
      createdBy: createdBy,
      modules: modules,
      createdAt: createdAt,
    );
  }

  factory UserModel.fromEntity(User params) {
    return UserModel(
      id: params.id,
      username: params.username,
      password: params.password,
      name: params.name,
      isActive: params.isActive,
      createdAt: params.createdAt,
      createdBy: params.createdBy,
      modules: params.modules,
    );
  }

  factory UserModel.fromDatabase(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      isActive: map['is_active'] != null ? map['is_active'] as int : null,
      createdBy: map['created_by'] != null ? map['created_by'] as String : null,
      createdAt:
          map['created_at'] != null ? map['created_at'] as DateTime : null,
      modules: map['modules'] != null
          ? map['modules'] as List<Map<String, dynamic>>
          : null,
    );
  }
}
