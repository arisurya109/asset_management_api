// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class CreateFailure extends Failure {
  const CreateFailure(super.message);
}

class UpdateFailure extends Failure {
  const UpdateFailure(super.message);
}

class DeleteFailure extends Failure {
  const DeleteFailure(super.message);
}
