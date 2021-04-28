import 'package:localstorage/localstorage.dart';

abstract class ILocalStorageService {
  Future<dynamic> getObject(String key);
  Future<dynamic> deleteObject(String key);
  Future<void> saveObject(String key, dynamic item);
  Future<void> clearAll();
}

class LocalStorageService implements ILocalStorageService {
  final LocalStorage _storage;

  LocalStorageService(String storageKey) : _storage = LocalStorage(storageKey);

  @override
  Future<dynamic> getObject(String key) async {
    await _storage.ready;
    return _storage.getItem(key);
  }

  @override
  Future<dynamic> deleteObject(String key) async {
    await _storage.ready;
    return _storage.deleteItem(key);
  }

  @override
  Future<void> saveObject(String key, dynamic value) async {
    await _storage.ready;
    return _storage.setItem(key, value);
  }

  @override
  Future<void> clearAll() async {
    await _storage.ready;
    return _storage.clear();
  }
}
