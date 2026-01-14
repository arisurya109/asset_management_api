// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/features/preparation/data/model/preparation_detail_model.dart';
import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail_response.dart';
import 'package:equatable/equatable.dart';

class PreparationDetailResponseModel extends Equatable {
  PreparationModel? preparation;
  List<PreparationDetailModel>? preparationDetail;

  PreparationDetailResponseModel({this.preparation, this.preparationDetail});

  factory PreparationDetailResponseModel.fromDatabase(
    Map<String, dynamic> map,
  ) {
    return PreparationDetailResponseModel(
      preparation: PreparationModel.fromMap(map),
      preparationDetail: map['items'] != null
          ? (map['items'] as List)
              .map(
                (e) => PreparationDetailModel.fromDatabase(
                  e as Map<String, dynamic>,
                ),
              )
              .toList()
          : null,
    );
  }

  PreparationDetailResponse toEntity() {
    return PreparationDetailResponse(
      preparation: preparation?.toEntity(),
      preparationDetail: preparationDetail?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [preparation, preparationDetail];
}
