// ignore_for_file: public_member_api_docs

abstract class ReprintLocalDataSource {
  Future<Map<String, dynamic>> reprintAsset(String params);
  Future<Map<String, dynamic>> reprintLocation(String params);
}
