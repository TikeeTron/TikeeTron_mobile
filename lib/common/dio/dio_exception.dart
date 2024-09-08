class AppException implements Exception {
  String message;

  AppException(this.message);

  AppException withMessage(String msg) {
    message = msg;
    return this;
  }

  static AppException fromResp(Map<String, dynamic> data) => AppException(data['message']);
}
