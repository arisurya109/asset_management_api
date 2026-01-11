// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:asset_management_api/features/assets/domain/entities/assets_detail.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_response.dart';
import 'package:equatable/equatable.dart';

class AssetDetailResponse extends Equatable {
  AssetsResponse? assets;
  List<AssetsDetail>? history;

  AssetDetailResponse({
    this.assets,
    this.history,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': assets?.id,
      'serial_number': assets?.serialNumber,
      'asset_code': assets?.assetCode,
      'status': assets?.status,
      'conditions': assets?.conditions,
      'quantity': assets?.quantity,
      'uom': assets?.uom,
      'model': assets?.model,
      'category': assets?.category,
      'brand': assets?.brand,
      'types': assets?.types,
      'color': assets?.color,
      'location': assets?.location,
      'location_detail': assets?.locationDetail,
      'purchase_order': assets?.purchaseOrder,
      'remarks': assets?.remarks,
      'transactions': history?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [assets, history];
}
