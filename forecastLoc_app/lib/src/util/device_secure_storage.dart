import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceSecureStorage {
  static Future<void> saveDataOnSecureStorage(String key, String value) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static Future<String> getDataFromSecureStorage(String key) async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: key);
  }
}