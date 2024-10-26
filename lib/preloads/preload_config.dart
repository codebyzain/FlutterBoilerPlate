import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/config_main.dart';
import 'package:flutter_application_1/utils/util_hive.dart';
import 'package:flutter_application_1/utils/util_logger.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class PreloadConfig {
  static load() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    AppLogger.log("Initiating Configurations");
    // Initiate flutter hive storage
    await Hive.initFlutter();
    await Hive.openBox<Map>(MainConfig.appName);
    // Removes all the previous network requests on debug mode
    if (MainConfig.debugMode) {
      const AppLocalStorage("network-debugger").delete();
      const AppLocalStorage("error-debugger").delete();
    }
    // Catches all flutter error
    FlutterError.onError = (FlutterErrorDetails details) {
      AppLogger.logError(details.exception);
    };
    AppLogger.log("App Configured");
  }
}
