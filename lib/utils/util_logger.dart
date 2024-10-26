import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter_application_1/configs/config_main.dart';
import 'package:flutter_application_1/utils/util_hive.dart';
import 'package:intl/intl.dart';

class AppLogger {
  static log(message) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(message);
    developer.log(
      prettyprint,
      name: "debug",
    );
  }

  static networkLog(method, path, response) {
    JsonEncoder encoder = const JsonEncoder.withIndent('   ');
    String prettyprint = encoder.convert(response);
    developer.log(
      prettyprint,
      name: "$method $path",
    );
  }

  static logError(errorString, {String? errorCategory}) {
    developer.log('$errorString', name: "error");
    if (MainConfig.debugMode) {
      var networkCollection =
          const AppLocalStorage("error-debugger").read() ?? {"data": []};
      DateTime now = DateTime.now();
      String formattedTime = DateFormat.Hms().format(now);
      networkCollection["data"].insert(0, {
        "error": '$errorString',
        "timestamp": formattedTime,
      });
      const AppLocalStorage(
        "error-debugger",
      ).insert(networkCollection);
    }
  }
}
