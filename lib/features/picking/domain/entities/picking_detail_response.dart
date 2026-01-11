// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management_api/features/picking/domain/entities/picking_detail.dart';
import 'package:asset_management_api/features/picking/domain/entities/picking_header.dart';
import 'package:equatable/equatable.dart';

class PickingDetailResponse extends Equatable {
  PickingHeader? pickingHeader;
  List<PickingDetail>? pickingDetail;

  PickingDetailResponse({
    this.pickingHeader,
    this.pickingDetail,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': pickingHeader?.id,
      'code': pickingHeader?.code,
      'status': pickingHeader?.status,
      'total_box': pickingHeader?.totalBox,
      'destination': {
        'id': pickingHeader?.destinationId,
        'name': pickingHeader?.destination,
      },
      'temporary_location': {
        'id': pickingHeader?.temporaryLocationId,
        'name': pickingHeader?.temporaryLocation,
      },
      'notes': pickingHeader?.notes,
      'total_items': pickingHeader?.totalItems,
      'total_quantity': pickingHeader?.totalQuantiy,
      'items': pickingDetail?.map((e) => e.toJson()).toList() ?? [],
    };
  }

  @override
  List<Object?> get props => [pickingHeader, pickingDetail];
}
