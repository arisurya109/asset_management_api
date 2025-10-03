// ignore_for_file: public_member_api_docs

extension StringExt on String? {
  bool isFilled() {
    return this != null && this!.trim().isNotEmpty;
  }
}
