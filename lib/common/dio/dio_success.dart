class AppSuccess {
  String message;

  AppSuccess(this.message);

  AppSuccess withMessage(String msg) {
    message = msg;
    return this;
  }

  static AppSuccess fromResp(Map<String, dynamic> data) =>
      AppSuccess(data['message']);
}
