import 'dart:developer';

class Logger {
  // blue
  static void info(
    String? message, {
    String? name,
  }) {
    log(
      "\x1B[34m$message\x1B[0m",
      name: name ?? "🥸",
    );
  }

  // green
  static void success(
    String? message, {
    String? name,
  }) {
    log(
      "\x1B[32m$message\x1B[0m",
      name: name ?? "🤩",
    );
  }

  // red
  static void error(
    String? message, {
    String? name,
  }) {
    log(
      "\x1B[31m$message\x1B[0m",
      name: name ?? "🤬",
    );
  }

  // yellow
  static void warning(
    String? message, {
    String? name,
  }) {
    log(
      "\x1B[33m$message\x1B[0m",
      name: name ?? "😔",
    );
  }
}
