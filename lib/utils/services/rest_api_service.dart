// import 'package:dio/dio.dart';

// class RestApiService {
//   Dio _dio;
//   Response response;

//   RestApiService() {
//     this._dio = Dio();
//   }

//   Future<dynamic> getRequest(String path, Options options,
//       {Map<String, dynamic> parameters}) async {
//     this.response = await this
//         ._dio
//         .get(path, queryParameters: parameters, options: options);

//     return this.response.data;
//   }

//   Future<> postRquest(String path, dynamic parameters){
//     await _dio.post(loginUrl, data: {
//       "email": phone,
//       "password": password,
//     });
//   }
// }
