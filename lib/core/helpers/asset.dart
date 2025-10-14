// ignore_for_file: public_member_api_docs

class AssetHelper {
  static String get templateCode {
    final now = DateTime.now();

    final years = '${now.year % 100}'.padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');

    return '$years$month$day';
  }
}
