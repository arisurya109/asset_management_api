// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/features/picking/data/model/picking_detail_model.dart';
import 'package:asset_management_api/features/picking/data/model/picking_header_model.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_detail_response.dart';
import 'package:equatable/equatable.dart';

class PickingDetailResponseModel extends Equatable {
  PickingHeaderModel? pickingHeader;
  List<PickingDetailModel>? pickingDetail;

  PickingDetailResponseModel({
    this.pickingHeader,
    this.pickingDetail,
  });

  factory PickingDetailResponseModel.fromMap(Map<String, dynamic> map) {
    return PickingDetailResponseModel(
      pickingHeader: PickingHeaderModel.fromDatabase(map),
      pickingDetail: map['items'] != null
          ? (map['items'] as List)
              .map(
                (e) => PickingDetailModel.fromDatabase(
                  e as Map<String, dynamic>,
                ),
              )
              .toList()
          : null,
    );
  }

  PickingDetailResponse toEntity() {
    return PickingDetailResponse(
      pickingHeader: pickingHeader?.toEntity(),
      pickingDetail: pickingDetail?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [pickingHeader, pickingDetail];
}
