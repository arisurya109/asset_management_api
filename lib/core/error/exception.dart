// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotFoundException implements Exception {
  String? message;

  NotFoundException({
    this.message,
  });
}

class CreateException implements Exception {
  String? message;

  CreateException({
    this.message,
  });
}

class UpdateException implements Exception {
  String? message;

  UpdateException({
    this.message,
  });
}

class DeleteException implements Exception {
  String? message;

  DeleteException({
    this.message,
  });
}

class DatabaseException implements Exception {
  String? message;

  DatabaseException({
    this.message,
  });
}
