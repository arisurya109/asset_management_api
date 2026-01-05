// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors_first

import 'package:asset_management_api/features/assets/assets_export.dart';
import 'package:asset_management_api/features/assets/domain/entities/assets_response_pagination.dart';
import 'package:equatable/equatable.dart';

class AssetsResponsePaginationModel extends Equatable {
  AssetsResponsePaginationModel({
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
  List<AssetsResponseModel>? assets;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'metadata': {
        'total_data': totalData,
        'current_page': currentPage,
        'last_page': lastPage,
        'limit': limit,
      },
      'data': assets?.map((e) => e.toJson()).toList(),
    };
  }

  factory AssetsResponsePaginationModel.fromDatabase(
    Map<String, dynamic> datas,
  ) {
    return AssetsResponsePaginationModel(
      totalData:
          datas['total_data'] != null ? datas['total_data'] as int : null,
      currentPage:
          datas['current_page'] != null ? datas['current_page'] as int : null,
      lastPage: datas['last_page'] != null ? datas['last_page'] as int : null,
      limit: datas['limit'] != null ? datas['limit'] as int : null,
      assets: datas['data'] != null
          ? (datas['data'] as List)
              .map(
                (e) => AssetsResponseModel.fromMap(e as Map<String, dynamic>),
              )
              .toList()
          : [],
    );
  }

  AssetsResponsePagination toEntity() {
    return AssetsResponsePagination(
      totalData: totalData,
      currentPage: currentPage,
      lastPage: lastPage,
      limit: limit,
      assets: assets?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [totalData, currentPage, lastPage, limit, assets];
}
