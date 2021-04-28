import 'dart:async';

import 'package:app/core/auth/bloc/auth_bloc.dart';
import 'package:app/repositories/repositories.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        var response = await userRepository.login(
          event.email,
          event.password,
        );

        if (response["success"]) {
          authenticationBloc.add(LoggedIn(token: response["token"]));
          yield LoginInitial();
        } else {
          yield LoginFailure(error: "Login Detail Error" ?? 'Unkown error');
        }
      } catch (error) {
        yield LoginFailure(error: "Login Details Error");
      }
    }
  }
}
