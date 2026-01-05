// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management_api/features/assets/domain/entities/assets_response.dart';
import 'package:equatable/equatable.dart';

class AssetsResponsePagination extends Equatable {
  AssetsResponsePagination({
    this.totalData,
    this.currentPage,
    this.lastPage,
    this.limit,
    this.assets,
  });

  int? totalData;
  int? currentPage;
  int? lastPage;
  int? limit;
  List<AssetsResponse>? assets;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': 'Successfully get assets',
      'metadata': {
        'total_data': totalData,
        'current_page': currentPage,
        'last_page': lastPage,
        'limit': limit,
      },
      'data': assets?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [totalData, currentPage, lastPage, limit, assets];
}
