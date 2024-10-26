import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/preloads/preload.dart';
import 'package:flutter_application_1/utils/util_logger.dart';

void main() {
  // Protect the main thread from unexpected errors
  runZonedGuarded(() async {
    // Load all configuration before the main app
    await AppPreloads.init();
    // Load main app
    runApp(const App());
  }, (error, stackTrace) {
    // Catches all the errors coming from UI Threads
    AppLogger.logError(error);
  });
}
