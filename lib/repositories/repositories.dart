import 'package:app/_index.dart';
import 'package:app/utils/models/user_model.dart';
import 'package:app/utils/services/secure_storage_service.dart';
import 'package:app/constants/api_path.dart';
import 'package:dio/dio.dart';

class UserRepository {
  var loginUrl = '$apiUrl/auth/login';

  final SecureLocalStorageService secureLocalStorageService =
      locator<SecureLocalStorageService>();
  final Dio restApiService = locator<Dio>();

  Future<bool> hasToken() async {
    return this.secureLocalStorageService.exist('token');
  }

  Future<void> persistToken(String token) async {
    await this.secureLocalStorageService.writeSecure('token', token);
  }

  Future<void> deleteToken() async {
    this.secureLocalStorageService.deleteSecure('token');
    this.secureLocalStorageService.deleteAllSecure();
  }

  Future<Map<String, dynamic>> login(String phone, String password) async {
    Response response = await this.restApiService.post(loginUrl, data: {
      "email": phone,
      "password": password,
    });
    if (response.data["accessToken"] != null) {
      var resp = {'success': true, 'token': response.data["accessToken"]};
      return resp;
    } else {
      return response.data;
    }
  }

  Future<UserModel> getUserByToken() async {
    var token = await this.secureLocalStorageService.readSecure('token');
    this.restApiService.options.headers["authorization"] = "Bearer $token";
    Response response = await this.restApiService.get(loginUrl);
    // if (response.data['uuid'] != null) {
    //   this.secureLocalStorageService.deleteSecure('uuid');
    //   this.secureLocalStorageService.writeSecure('uuid', response.data['uuid']);
    // }
    //
    return UserModel.fromJson(response.data);
  }
}
