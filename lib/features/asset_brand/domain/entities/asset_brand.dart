// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors

import 'package:equatable/equatable.dart';

class AssetBrand extends Equatable {
  AssetBrand({
    this.id,
    this.name,
    this.init,
  });

  factory AssetBrand.fromRequest(Map<String, dynamic> map) {
    return AssetBrand(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
    );
  }
  int? id;
  String? name;
  String? init;

  Map<String, dynamic> toResponse() {
    return {
      'id': id,
      'name': name,
      'init': init,
    };
  }

  @override
  List<Object?> get props => [id, name, init];
}
