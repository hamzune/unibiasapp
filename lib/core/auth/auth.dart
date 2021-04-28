import 'package:app/core/auth/login/login_screen.dart';
import 'package:app/core/auth/widgets/background_painter.dart';
import 'package:app/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import './widgets/register.dart';
import 'login/sign_in.dart';
// import 'package:lit_firebase_ui_demo/screens/home.dart';

class AuthScreen extends StatefulWidget {
  final UserRepository userRepository;
  const AuthScreen({Key key, @required this.userRepository}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller,
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ValueListenableBuilder<bool>(
                valueListenable: showSignInPage,
                builder: (context, value, child) {
                  return SizedBox.expand(
                    child: PageTransitionSwitcher(
                      reverse: !value,
                      duration: const Duration(milliseconds: 800),
                      transitionBuilder:
                          (child, animation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.vertical,
                          fillColor: Colors.transparent,
                          child: child,
                        );
                      },
                      child: value
                          // ? SignIn(
                          //     key: const ValueKey('SignIn'),
                          //     onRegisterClicked: () {
                          //       // context.resetSignInForm();
                          //       showSignInPage.value = false;
                          //       _controller.forward();
                          //     },
                          //   )
                          ? LoginScreen(
                              userRepository: widget.userRepository,
                              key: const ValueKey('SignIn'),
                              onRegisterClicked: () {
                                // context.resetSignInForm();
                                showSignInPage.value = false;
                                _controller.forward();
                              },
                            )
                          : Register(
                              key: const ValueKey('Register'),
                              onSignInPressed: () {
                                // context.resetSignInForm();
                                showSignInPage.value = true;
                                _controller.reverse();
                              },
                            ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
