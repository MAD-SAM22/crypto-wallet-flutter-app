import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _keyToken = 'token';
  static const String _keyName = 'fullname';
  static const String _keyPhone = 'phoneno';
  static const String _keyEmail = 'email';
  static const String _keyPassword = 'password';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future<void> saveUserData(String email, String password , String fullname, String phonenum) async {
    await _storage.write(key: _keyName, value: fullname);
    await _storage.write(key: _keyPhone, value: phonenum);

    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyPassword, value: password);
  }

  static Future<Map<String, String?>> getUserData() async {
    String? fullname = await _storage.read(key: _keyName);
    String? phoneno = await _storage.read(key: _keyPhone);

    String? email = await _storage.read(key: _keyEmail);
    String? password = await _storage.read(key: _keyPassword);
    return {'fullname': fullname,  'phoneno': phoneno, 'email': email, 'password': password};
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
