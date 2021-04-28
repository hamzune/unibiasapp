import 'package:app/config/routes/skeleton.dart';
import 'package:app/config/themes/light_theme.dart';
import 'package:app/core/auth/auth.dart';
import 'package:app/core/auth/bloc/auth_bloc.dart';
import 'package:app/core/auth/intro_screen.dart';
import 'package:app/repositories/repositories.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialScreen extends StatelessWidget {
  final UserRepository userRepository;

  InitialScreen({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          // return MainScreen(user: state.user);
          return Sketeleton();
        }
        if (state is AuthenticationUnauthenticated) {
          return AuthScreen(userRepository: userRepository);
        }
        if (state is AuthenticationLoading) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          LightThemeColors.spinner),
                      strokeWidth: 4.0,
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Container(
            // color: LightThemeColors.background,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        LightThemeColors.spinner),
                    strokeWidth: 4.0,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
