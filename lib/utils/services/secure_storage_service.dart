import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;

class SecureLocalStorageService {
  Storage.FlutterSecureStorage storage;

  SecureLocalStorageService() {
    this.storage = new Storage.FlutterSecureStorage();
  }

  Future<String> readSecure(String key) {
    return storage.read(key: key);
  }

  Future<bool> exist(String key) async {
    dynamic value = await this.readSecure(key);
    if (value != null) {
      return true;
    }
    return false;
  }

  Future<void> writeSecure(String key, String data) async {
    storage.write(key: key, value: data);
  }

  Future<void> deleteSecure(String key) async {
    storage.delete(key: key);
  }

  Future<void> deleteAllSecure() async {
    storage.deleteAll();
  }
}
