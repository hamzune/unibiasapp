import 'package:app/core/auth/bloc/auth_bloc.dart';
import 'package:app/core/auth/login/sign_in.dart';
import 'package:app/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  final VoidCallback onRegisterClicked;

  LoginScreen({
    Key key,
    @required this.userRepository,
    @required this.onRegisterClicked,
  })  : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: SignIn(
            key: const ValueKey('SignIn'),
            userRepository: userRepository,
            onRegisterClicked: onRegisterClicked));
  }
}
