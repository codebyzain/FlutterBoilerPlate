import 'package:flutter_application_1/configs/config_main.dart';
import 'package:flutter_application_1/utils/util_logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppLocalStorage {
  final String storageName = MainConfig.appName;
  final String collection;

  const AppLocalStorage(this.collection);

  insert(value) {
    try {
      var box = Hive.box<Map>(storageName);
      box.put(collection, value);
    } catch (e) {
      AppLogger.logError(e);
      return null;
    }
  }

  read() {
    try {
      final box = Hive.box<Map>(storageName);
      final data = box.get(collection);
      return data;
    } catch (e) {
      AppLogger.logError(e);
      return null;
    }
  }

  delete() {
    try {
      final box = Hive.box<Map>(storageName);
      final data = box.delete(collection);
      return data;
    } catch (e) {
      AppLogger.logError(e);
      return null;
    }
  }
}
