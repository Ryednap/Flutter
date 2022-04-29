import 'package:logger/logger.dart';

class ServiceSettings {
  static const String HOST = '192.168.100.1';
  static const int PORT = 8080;
  static const String LOGIN_PATH = 'login';
  static const String MEDICINE_PATH = "api/v1/medicine";
  static const String REGISTER_PATH = "api/user/save";
  static const String UPDATE_PATH = "api/v1/medicine/update";
  static const String RING_PATH = "api/ring";
  static final logger = Logger();
}