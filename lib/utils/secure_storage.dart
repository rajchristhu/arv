// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _Item {
  _Item(this.key, this.value);

  final String key;
  final String value;
}

// ignore: library_private_types_in_public_api
_SecureStorage secureStorage = _SecureStorage.instance;

class _SecureStorage {
  _SecureStorage._();

  static final _SecureStorage instance = _SecureStorage._();

  final _accountNameController =
      TextEditingController(text: 'secure_storage_service');

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  List<_Item> items = [];

  Future<String?> get(String key) async {
    _Item? item;
    try {
      item = items
          .where((element) => element.key.toLowerCase() == key.toLowerCase())
          .first;
    } catch (e) {
      log("Not Found Exception: $e");
    }
    getAll();
    return item?.value;
  }

  Future<void> delete(String key) async {
    FlutterSecureStorage.setMockInitialValues({});
    await storage.delete(
      key: key.toLowerCase(),
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
      webOptions: _getWebOptions(),
      lOptions: _getLinuxOptions(),
      wOptions: _getWindowsOptions(),
    );
    getAll();
  }

  Future<void> getAll() async {
    final all = await storage.readAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
      webOptions: _getWebOptions(),
      lOptions: _getLinuxOptions(),
      wOptions: _getWindowsOptions(),
    );
    items = all.entries
        .map((entry) => _Item(entry.key, entry.value))
        .toList(growable: false);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
      webOptions: _getWebOptions(),
      lOptions: _getLinuxOptions(),
      wOptions: _getWindowsOptions(),
    );
    getAll();
  }

  Future<void> add(String key, String value) async {
    await storage.write(
      key: key.toLowerCase(),
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
      webOptions: _getWebOptions(),
      lOptions: _getLinuxOptions(),
      wOptions: _getWindowsOptions(),
    );
    getAll();
  }

  Future<void> init() async {
    _accountNameController.addListener(() => getAll());
    getAll();
  }

  IOSOptions _getIOSOptions() => IOSOptions(accountName: _getAccountName());

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  WebOptions _getWebOptions() => WebOptions.defaultOptions;

  LinuxOptions _getLinuxOptions() => LinuxOptions.defaultOptions;

  WindowsOptions _getWindowsOptions() => WindowsOptions.defaultOptions;

  String? _getAccountName() =>
      _accountNameController.text.isEmpty ? null : _accountNameController.text;
}
