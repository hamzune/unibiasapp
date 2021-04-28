import 'package:app/utils/services/local_storage_service.dart';
import 'package:app/utils/services/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // SERVICIOS CONTROL
  locator.registerLazySingleton(() => SecureLocalStorageService());
  locator.registerLazySingleton(() => Dio());
  locator
      .registerLazySingleton(() => LocalStorageService('unibias_datos.json'));

  // SERVICIOS GENERALES
  // locator.registerLazySingleton(() => NavigationService());
  // locator.registerLazySingleton(() => AuthenticationService());
  // locator.registerLazySingleton(() => RequestService());
  // locator.registerLazySingleton(() => SourceService());
}
