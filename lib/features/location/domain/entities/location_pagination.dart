// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management_api/features/location/location_export.dart';
import 'package:equatable/equatable.dart';

class LocationPagination extends Equatable {
  LocationPagination({
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
  List<Location>? locations;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': 'Successfully get locations',
      'metadata': {
        'total_data': totalData,
        'current_page': currentPage,
        'last_page': lastPage,
        'limit': limit,
      },
      'data': locations?.map((e) => e.toResponse()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        totalData,
        currentPage,
        lastPage,
        limit,
        locations,
      ];
}
