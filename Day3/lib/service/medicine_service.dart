import 'dart:convert';

import 'package:home_ui/models/medicine_model.dart';
import 'package:home_ui/service/service_settings.dart';
import 'package:home_ui/service/storage_service.dart';
import 'package:http/http.dart' as http;


class MedicineService {
  static final _uriEndpoint = Uri.parse('http://${ServiceSettings.HOST}:${ServiceSettings.PORT}/${ServiceSettings.MEDICINE_PATH}');

  static Future<List<MedicineModel>?> getMedicineList({required String date, required dynamic status}) async {
    final accessToken = await StorageService.retrieveToken(tokenName: 'access-token');
    assert (accessToken != null);
    final response = await http.get(
      Uri.parse('http://${ServiceSettings.HOST}:${ServiceSettings.PORT}/${ServiceSettings.MEDICINE_PATH}/date/$date/$status'),
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $accessToken',
      },
    );

    ServiceSettings.logger.d('Received Response ${response.statusCode}');
    if (response.statusCode != 202) {
      return null;
    }

    final jsonDecoded = await jsonDecode(response.body);
    ServiceSettings.logger.d('Body $jsonDecoded');
    return (jsonDecoded['medicineList'] as List)
        .map((model) => MedicineModel.fromJson(model))
        .toList();
  }

  static Future<dynamic> postMedicine(MedicineModel model) async {
    final accessToken = await StorageService.retrieveToken(tokenName: 'access-token');
    final response = await http.post(
      _uriEndpoint,
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $accessToken',
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode != 200) {
      return null;
    }
    final jsonDecoded = await jsonDecode(response.body);
    ServiceSettings.logger.d("Post decoded response body: $jsonDecoded");
    model.id = jsonDecoded['id'];
    ServiceSettings.logger.i('Model: model');
    return model;
  }

  static Future<dynamic> deleteMedicine({required dynamic id}) async {
    final accessToken = await StorageService.retrieveToken(tokenName: 'access-token');
    final response = await http.delete(
      Uri.parse('http://${ServiceSettings.HOST}:${ServiceSettings.PORT}/${ServiceSettings.MEDICINE_PATH}/$id'),
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $accessToken',
      },
    );
    ServiceSettings.logger.d('Received Response for DELETE request ${response.statusCode}');
    if (response.statusCode != 202) return false;
    return true;
  }

  static Future<dynamic> updateMedicineStatus({required dynamic id, required dynamic status}) async {
    final accessToken = await StorageService.retrieveToken(tokenName: 'access-token');
    final response = await http.put(
      Uri.parse('http://${ServiceSettings.HOST}:${ServiceSettings.PORT}/${ServiceSettings.UPDATE_PATH}/$id/$status'),
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $accessToken',
      },
    );
    ServiceSettings.logger.d('Received Response ${response.statusCode}');
    if (response.statusCode != 202) return false;
    return true;
  }

  static Future<dynamic> postRingTime({required dynamic name, required dynamic dosage, required dynamic description, required dynamic type}) async {
    Map<String, String> body = {
      'name' : name,
      'dosage' : "2",
      'description' : description,
      'type' : type
    };
    final response = await http.post(
      Uri.parse('http://${ServiceSettings.HOST}:${ServiceSettings.PORT}/${ServiceSettings.RING_PATH}'),
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
      },
      body: jsonEncode(body)
    );
    ServiceSettings.logger.d('Received Response ${response.statusCode}');
    if (response.statusCode != 200) return false;
    return true;

  }
}