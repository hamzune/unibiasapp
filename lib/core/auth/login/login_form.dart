import 'package:app/config/themes/dark_theme.dart';
import 'package:app/config/themes/light_theme.dart';
import 'package:app/repositories/repositories.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;
  LoginForm({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepository);
}

class _LoginFormState extends State<LoginForm> {
  final UserRepository userRepository;
  _LoginFormState(this.userRepository);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
            color: LightThemeColors.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 35.0,
                        left: 35.0,
                        top: 40,
                        bottom: MediaQuery.of(context).padding.bottom),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // IconButton(
                          //   icon: Icon(EvaIcons.cornerUpLeft),
                          //   iconSize: 35.0,
                          //   onPressed: () =>
                          //       {ExtendedNavigator.of(context).pop()},
                          //   alignment: Alignment.topLeft,
                          //   color: DarkThemeColors.mainColor,
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Let's sign you in.",
                            style: TextStyle(
                                color: LightThemeColors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 40),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Welcome back,",
                            style: TextStyle(
                                fontSize: 33,
                                color: LightThemeColors.mainColor),
                          ),
                          Text(
                            "You've been missed!",
                            style: TextStyle(
                                fontSize: 33,
                                color: LightThemeColors.mainColor),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 17.0,
                              color: LightThemeColors.mainColor,
                            ),
                            controller: _usernameController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: LightThemeColors.inputBorder),
                                  borderRadius: BorderRadius.circular(15.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: LightThemeColors.inputBorder),
                                  borderRadius: BorderRadius.circular(15.0)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: LightThemeColors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            autocorrect: false,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: LightThemeColors.grey,
                            ),
                            controller: _passwordController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: LightThemeColors.inputBorder),
                                  borderRadius: BorderRadius.circular(15.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: LightThemeColors.inputBorder),
                                  borderRadius: BorderRadius.circular(15.0)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: LightThemeColors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            autocorrect: false,
                            obscureText: true,
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(
                                  height: 55,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              LightThemeColors.mainColor),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              LightThemeColors.background),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: state is LoginLoading
                                        ? null
                                        : _onLoginButtonPressed,
                                    child: state is LoginLoading
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 25.0,
                                                    width: 25.0,
                                                    child:
                                                        CupertinoActivityIndicator(),
                                                  )
                                                ],
                                              ))
                                            ],
                                          )
                                        : Text(
                                            "Sign In",
                                            style: new TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
