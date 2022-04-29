import 'dart:convert';

import 'package:home_ui/service/service_settings.dart';
import 'package:home_ui/service/storage_service.dart';
import 'package:http/http.dart' as http;


class AuthenticationService {

  static Future<bool> login({required String email, required String password}) async {
    ServiceSettings.logger.d('email : $email, password: $password');
    Map<String, String> formData = {
      'email' : email,
      'password' : password
    };
    final response = await http.post(
      Uri.parse('http://${ServiceSettings.HOST}:${ServiceSettings.PORT}/${ServiceSettings.LOGIN_PATH}'),
      body: formData,
    );

    ServiceSettings.logger.d("Response: ${response.statusCode}");
    if (response.statusCode != 200) return false;
    final jsonResponse = await jsonDecode(response.body);
    StorageService.storeToken(tokenName: "access-token", token: jsonResponse['access-token']);
    StorageService.storeToken(tokenName: "refresh-token", token: jsonResponse['refresh-token']);
    return true;
  }

  static Future<bool> register({required String userName, required String email, required String password}) async{
    ServiceSettings.logger.d('username: $userName, password: $password, email: $email');
    Map<String, String> formData = {
      'name' : userName,
      'email' : email,
      'password' : password
    };
    final response = await http.post(
      Uri.parse('http://${ServiceSettings.HOST}:${ServiceSettings.PORT}/${ServiceSettings.REGISTER_PATH}'),
      headers: {
        'Content-Type' : 'application/json',
      },
      body: jsonEncode(formData),
    );

    ServiceSettings.logger.d("Response: ${response.statusCode}");
    if (response.statusCode != 201) return false;
    return true;
  }
}