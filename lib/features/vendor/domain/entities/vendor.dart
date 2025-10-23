// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Vendor extends Equatable {
  int? id;
  String? name;
  String? init;
  String? phone;
  String? description;
  int? createdBy;
  int? updatedBy;

  Vendor({
    this.id,
    this.name,
    this.init,
    this.phone,
    this.description,
    this.createdBy,
    this.updatedBy,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'init': init,
      'phone': phone,
      'description': description,
    };
  }

  factory Vendor.fromJson(Map<String, dynamic> map) {
    return Vendor(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      createdBy: map['created_by'] != null ? map['created_by'] as int : null,
      updatedBy: map['updated_by'] != null ? map['updated_by'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      init,
      phone,
      description,
    ];
  }
}
