// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management_api/features/preparation/domain/entities/preparation.dart';
import 'package:equatable/equatable.dart';

class PreparationPagination extends Equatable {
  PreparationPagination({
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
  List<Preparation>? preparations;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': 'Successfully get preparations',
      'metadata': {
        'total_data': totalData,
        'current_page': currentPage,
        'last_page': lastPage,
        'limit': limit,
      },
      'data': preparations?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        totalData,
        currentPage,
        lastPage,
        limit,
        preparations,
      ];
}
