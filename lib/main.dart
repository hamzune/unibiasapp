// import 'package:app/utils/services/local_storage_service.dart';
import 'package:app/_index.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/auth/bloc/auth_bloc.dart';
import 'package:app/repositories/repositories.dart';

void main() {
  setupLocator();

  final userRepository = UserRepository();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository),
      // child: MyApp(),
    ),
  );
}
