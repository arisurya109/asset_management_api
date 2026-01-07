// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors_first

import 'package:asset_management_api/features/preparation/data/model/preparation_model.dart';
import 'package:asset_management_api/features/preparation/domain/entities/preparation_pagination.dart';
import 'package:equatable/equatable.dart';

class PreparationPaginationModel extends Equatable {
  PreparationPaginationModel({
    this.totalData,
    this.currentPage,
    this.lastPage,
    this.limit,
    this.preparations,
  });

  int? totalData;
  int? currentPage;
  int? lastPage;
  int? limit;
  List<PreparationModel>? preparations;

  factory PreparationPaginationModel.fromDatabase(
    Map<String, dynamic> datas,
  ) {
    return PreparationPaginationModel(
      totalData:
          datas['total_data'] != null ? datas['total_data'] as int : null,
      currentPage:
          datas['current_page'] != null ? datas['current_page'] as int : null,
      lastPage: datas['last_page'] != null ? datas['last_page'] as int : null,
      limit: datas['limit'] != null ? datas['limit'] as int : null,
      preparations: datas['data'] != null
          ? (datas['data'] as List)
              .map(
                (e) => PreparationModel.fromJson(e as Map<String, dynamic>),
              )
              .toList()
          : [],
    );
  }

  PreparationPagination toEntity() {
    return PreparationPagination(
      totalData: totalData,
      currentPage: currentPage,
      lastPage: lastPage,
      limit: limit,
      preparations: preparations?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props =>
      [totalData, currentPage, lastPage, limit, preparations];
}
