// When using REST API service in dart then we can store all the API endpoints in a separate file api_path.dart
import 'package:flutter/material.dart';

final String appName = 'UNIBIAS';
const String apiUrl = 'https://api.unibias.com';
const Locale defaulLanguage = Locale('es', 'ES');

class APIPATHS {
  static const String user_url_login = apiUrl + '/user/login';
  static const String user_url_info = apiUrl + '/user/info';
}
