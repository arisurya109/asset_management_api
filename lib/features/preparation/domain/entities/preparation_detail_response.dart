// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_detail.dart';
import 'package:equatable/equatable.dart';

class PreparationDetailResponse extends Equatable {
  Preparation? preparation;
  List<PreparationDetail>? preparationDetail;

  PreparationDetailResponse({this.preparation, this.preparationDetail});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': preparation?.id,
      'code': preparation?.code,
      'status': preparation?.status,
      'total_box': preparation?.totalBox,
      'destination': {
        'id': preparation?.destinationId,
        'code': preparation?.destinationCode,
        'init': preparation?.destinationInit,
        'name': preparation?.destination,
      },
      'created': {'id': preparation?.createdId, 'name': preparation?.created},
      'approved': {
        'id': preparation?.approvedId,
        'name': preparation?.approved,
      },
      'worker': {'id': preparation?.workerId, 'name': preparation?.worker},
      'location': {
        'id': preparation?.locationId,
        'name': preparation?.location,
      },
      'created_at': preparation?.createdAt?.toIso8601String(),
      'notes': preparation?.notes,
      'items': preparationDetail?.map((e) => e.toJson()).toList() ?? [],
    };
  }

  @override
  List<Object?> get props => [preparation, preparationDetail];
}
