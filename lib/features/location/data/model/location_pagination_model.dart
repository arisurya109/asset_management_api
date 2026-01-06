// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors_first

import 'package:asset_management_api/features/location/domain/entities/location_pagination.dart';
import 'package:asset_management_api/features/location/location_export.dart';
import 'package:equatable/equatable.dart';

class LocationPaginationModel extends Equatable {
  LocationPaginationModel({
    this.totalData,
    this.currentPage,
    this.lastPage,
    this.limit,
    this.locations,
  });

  int? totalData;
  int? currentPage;
  int? lastPage;
  int? limit;
  List<LocationModel>? locations;

  factory LocationPaginationModel.fromDatabase(
    Map<String, dynamic> datas,
  ) {
    return LocationPaginationModel(
      totalData:
          datas['total_data'] != null ? datas['total_data'] as int : null,
      currentPage:
          datas['current_page'] != null ? datas['current_page'] as int : null,
      lastPage: datas['last_page'] != null ? datas['last_page'] as int : null,
      limit: datas['limit'] != null ? datas['limit'] as int : null,
      locations: datas['data'] != null
          ? (datas['data'] as List)
              .map(
                (e) => LocationModel.fromDatabase(e as Map<String, dynamic>),
              )
              .toList()
          : [],
    );
  }

  LocationPagination toEntity() {
    return LocationPagination(
      totalData: totalData,
      currentPage: currentPage,
      lastPage: lastPage,
      limit: limit,
      locations: locations?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props =>
      [totalData, currentPage, lastPage, limit, locations];
}
