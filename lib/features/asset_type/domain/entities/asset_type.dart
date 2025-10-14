// ignore_for_file: public_member_api_docs, must_be_immutable,

import 'package:equatable/equatable.dart';

class AssetType extends Equatable {
  AssetType({
    this.id,
    this.name,
    this.init,
  });

  int? id;
  String? name;
  String? init;

  // ignore: sort_constructors_first
  factory AssetType.fromRequest(Map<String, dynamic> params) {
    return AssetType(
      id: params['id'] != null ? params['id'] as int : null,
      name: params['name'] != null ? params['name'] as String : null,
      init: params['init'] != null ? params['init'] as String : null,
    );
  }

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
