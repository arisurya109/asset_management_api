// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  int? id;
  String? username;
  String? password;
  String? name;
  int? isActive;
  DateTime? createdAt;
  String? createdBy;
  List<Map<String, dynamic>>? modules;

  User({
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

  Map<String, dynamic> toResponseLogin() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'name': name,
      'modules': modules,
    };
  }

  Map<String, dynamic> toResponse() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory User.fromRequest(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      createdBy: map['created_by'] != null ? map['created_by'] as String : null,
      modules: map['modules'] != null
          ? map['modules'] as List<Map<String, dynamic>>
          : null,
    );
  }
}
