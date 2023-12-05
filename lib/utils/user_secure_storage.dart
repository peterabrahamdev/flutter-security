import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _usernameKey = 'username';
  static const _passwordKey = 'password';

  static Future<void> setUsername(String username) async =>
      await _storage.write(key: _usernameKey, value: username);

  static Future<void> setPassword(String password) async =>
      await _storage.write(key: _passwordKey, value: password);

  static Future<String?> getUsername() async => await _storage.read(key: _usernameKey);
  static Future<String?> getPassword() async => await _storage.read(key: _passwordKey);
}
