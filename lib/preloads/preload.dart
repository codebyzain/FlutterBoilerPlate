import 'package:flutter_application_1/preloads/preload_config.dart';

// Registers all the preload configs here
class AppPreloads {
  static init() async {
    await PreloadConfig.load();
  }
}
