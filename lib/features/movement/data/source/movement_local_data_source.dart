// ignore_for_file: public_member_api_docs

import 'package:asset_management_api/features/movement/data/model/movement_model.dart';

// ignore: one_member_abstracts
abstract class MovementLocalDataSource {
  Future<String> createMovement({
    required MovementModel params,
    required int userId,
  });
}
