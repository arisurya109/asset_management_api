// ignore_for_file: public_member_api_docs, must_be_immutable,

import 'package:equatable/equatable.dart';

class AssetType extends Equatable {
  AssetType({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  // ignore: sort_constructors_first
  factory AssetType.fromRequest(Map<String, dynamic> params) {
    return AssetType(
      id: params['id'] != null ? params['id'] as int : null,
      name: params['name'] != null ? params['name'] as String : null,
    );
  }

  Map<String, dynamic> toResponse() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}
