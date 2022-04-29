import 'dart:ffi';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class StorageService {
  static const _secureStorage = FlutterSecureStorage();
  static final logger = Logger();

  static void storeToken({required String tokenName, required String token}) async {
    logger.d("Saving Token : $tokenName: $token");
    await _secureStorage.write(key: tokenName, value: token);
  }

  static Future<String?> retrieveToken({required String tokenName}) async {
    if (await _secureStorage.containsKey(key: tokenName)) {
      String token = await _secureStorage.read(key: tokenName) as String;
      return token;
    }
    return null;
  }

  static void storeUser({required userName}) {
    _secureStorage.write(key: "userName", value: userName);
  }

  static Future<String?> retrieveUserName() async {
    return await _secureStorage.read(key: "userName");
  }
}