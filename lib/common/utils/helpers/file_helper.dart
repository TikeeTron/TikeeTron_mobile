class FileHelper {
  static bool isFromNetwork(String path) {
    return path.startsWith(RegExp('http|https'));
  }
}
