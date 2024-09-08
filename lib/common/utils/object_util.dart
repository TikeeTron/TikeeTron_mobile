class ObjectUtil {
  static bool notNullAndEmptyString(dynamic data) {
    if (data != null && data is String && data.isNotEmpty) {
      return true;
    }

    return false;
  }

  static bool notNullAndEmpty(dynamic data) {
    if (data != null && data.isNotEmpty) {
      return true;
    }

    return false;
  }

  static bool notNullAndEmptyList(List<dynamic>? data) {
    if (data != null && data.isNotEmpty) {
      return true;
    }

    return false;
  }

  static bool isEmptyList(List<dynamic>? data) {
    if (data != null && data.isEmpty) {
      return true;
    }

    return false;
  }

  static bool notStringAndNull(dynamic data) {
    if (data != null && data is! String) {
      return true;
    }

    return false;
  }
}
