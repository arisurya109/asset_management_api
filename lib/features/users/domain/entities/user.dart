// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({
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

  @override
  List<Object?> get props =>
      [id, username, name, password, isActive, createdBy, createdDate];
}
