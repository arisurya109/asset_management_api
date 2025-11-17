// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:asset_management_api/core/error/failure.dart';
import 'package:asset_management_api/features/preparation/domain/repositories/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindDocumentPreparationByIdUseCase {
  FindDocumentPreparationByIdUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, File>> call(int params) async {
    return _repository.findDocumentPreparationById(params);
  }
}
