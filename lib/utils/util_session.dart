import 'package:flutter_keychain/flutter_keychain.dart';

class AppSession {
  // Store new session
  static store(String key, String value) async {
    try {
      await FlutterKeychain.put(key: key, value: value);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get session
  static get(String key) async {
    try {
      final data = await FlutterKeychain.get(key: key);
      return data;
    } catch (e) {
      return false;
    }
  }

  // Delete existing session
  static delete(String key) async {
    try {
      await FlutterKeychain.remove(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Clear all sessions
  static clear(String key) async {
    try {
      await FlutterKeychain.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}
