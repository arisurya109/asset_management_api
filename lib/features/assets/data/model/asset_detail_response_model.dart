// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/assets/data/model/assets_detail_model.dart';
import 'package:asset_management_api/features/assets/domain/entities/asset_detail_response.dart';
import 'package:equatable/equatable.dart';

class AssetDetailResponseModel extends Equatable {
  AssetsResponseModel? assets;
  List<AssetsDetailModel>? history;

  AssetDetailResponseModel({
    this.assets,
    this.history,
  });

  factory AssetDetailResponseModel.fromMap(Map<String, dynamic> map) {
    return AssetDetailResponseModel(
      assets: AssetsResponseModel.fromMap(map),
      history: map['history'] != null
          ? (map['history'] as List)
              .map(
                (e) =>
                    AssetsDetailModel.fromDatabase(e as Map<String, dynamic>),
              )
              .toList()
          : null,
    );
  }

  AssetDetailResponse toEntity() {
    return AssetDetailResponse(
      assets: assets?.toEntity(),
      history: history?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [assets, history];
}
