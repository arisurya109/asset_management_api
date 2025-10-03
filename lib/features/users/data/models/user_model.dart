// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors_first, avoid_unused_constructor_parameters

import 'package:asset_management_api/features/users/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  UserModel({
    this.id,
    this.username,
    this.name,
    this.password,
    this.isActive,
    this.createdBy,
    this.createdDate,
  });

  int? id;
  String? username;
  String? name;
  String? password;
  int? isActive;
  String? createdBy;
  DateTime? createdDate;

  factory UserModel.fromEntity(User params) {
    return UserModel(
      id: params.id,
      username: params.username,
      password: params.password,
      name: params.name,
      isActive: params.isActive,
      createdBy: params.createdBy,
      createdDate: params.createdDate,
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: username,
      password: password,
      name: name,
      isActive: isActive,
      createdBy: createdBy,
      createdDate: createdDate,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      username: map['user_id'] as String?,
      name: map['name'] as String?,
      password: map['password'] as String?,
      isActive: map['is_active'] as int?,
      createdBy: map['created_by'] as String?,
      createdDate: map['created_date'] as DateTime?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        password,
        isActive,
        createdBy,
        createdDate,
      ];
}
