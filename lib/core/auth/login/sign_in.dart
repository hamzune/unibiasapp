import 'package:app/core/auth/widgets/decoration_functions.dart';
import 'package:app/core/auth/widgets/palette.dart';
import 'package:app/core/auth/widgets/sign_in_up_bar.dart';
import 'package:app/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/title.dart';
import 'bloc/login_bloc.dart';

class SignIn extends StatefulWidget {
  SignIn(
      {Key key,
      @required this.onRegisterClicked,
      @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  final VoidCallback onRegisterClicked;
  final UserRepository userRepository;

  @override
  State<SignIn> createState() => _SignInState(userRepository);
}

class _SignInState extends State<SignIn> {
  final UserRepository userRepository;
  _SignInState(this.userRepository);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          email: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: LoginTitle(
                        title: 'Welcome\nBack',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: TextFormField(
                            controller: _usernameController,
                            decoration:
                                signInInputDecoration(hintText: 'Email'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  }),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                              hintStyle: const TextStyle(fontSize: 18),
                              hintText: 'Password',
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Palette.darkBlue),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Palette.darkBlue),
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Palette.darkOrange),
                              ),
                              focusedErrorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: Palette.darkOrange),
                              ),
                              errorStyle:
                                  const TextStyle(color: Palette.darkOrange),
                            ),
                            obscureText: _obscureText,
                          ),
                        ),
                        SignInBar(
                          label: 'Sign in',
                          isLoading: state is LoginLoading,
                          onPressed: state is LoginLoading
                              ? null
                              : _onLoginButtonPressed,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              widget.onRegisterClicked?.call();
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: Palette.darkBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
