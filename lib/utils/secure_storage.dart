// ignore_for_file: depend_on_referenced_packages

import 'package:shared_preferences/shared_preferences.dart';

// ignore: library_private_types_in_public_api
_SecureStorage secureStorage = _SecureStorage.instance;

class _SecureStorage {
  _SecureStorage._();

  late SharedPreferences sp;

  static final _SecureStorage instance = _SecureStorage._();

  Future<String> get(String key) async {
    return sp.getString(key) ?? "";
  }

  Future<void> delete(String key) async {
    sp.remove(key);
  }

  Future<void> deleteAll() async {
    sp.clear();
  }

  Future<void> add(String key, String value) async {
    sp.setString(key, value);
  }

  Future<void> init() async {
    sp = await SharedPreferences.getInstance();
  }
}
