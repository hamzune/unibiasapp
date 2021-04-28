import 'package:app/config/routing/modular_router.gr.dart';
import 'package:app/config/themes/dark_theme.dart';
import 'package:app/config/themes/light_theme.dart';
import 'package:app/repositories/repositories.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatefulWidget {
  final UserRepository userRepository;
  IntroPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState(userRepository);
}

class _IntroPageState extends State<IntroPage> {
  final UserRepository userRepository;
  _IntroPageState(this.userRepository);

  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: Text(
        'College student\'s tools.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: LightThemeColors.mainColor,
        ),
      ),
      body:
          "Bring together your files, your tools, projects and people. Including a new mobile and desktop application.",
      image: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(child: Image.asset("assets/images/onboarding1.png")),
      ),
      decoration: const PageDecoration(
        pageColor: Colors.transparent,
        descriptionPadding: EdgeInsets.only(left: 30, right: 30),
        bodyTextStyle: TextStyle(
          color: LightThemeColors.strongGrey,
          fontSize: 18,
        ),
        // descriptionPadding: EdgeInsets.only(left: 20, right: 20),
        imagePadding: EdgeInsets.all(20),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 20),
      color: LightThemeColors.background,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: IntroductionScreen(
              globalBackgroundColor: Colors.transparent,
              controlsPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              pages: pages,
              showDoneButton: false,
              showNextButton: false,
              showSkipButton: false,
              dotsDecorator: DotsDecorator(
                size: const Size.square(7.0),
                activeSize: const Size(20.0, 5.0),
                activeColor: LightThemeColors.background,
                color: LightThemeColors.background,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              decoration: BoxDecoration(
                color: LightThemeColors.secondaryColor,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              LightThemeColors.mainColor),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              LightThemeColors.background),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Register",
                          style: new TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            LightThemeColors.mainColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        ExtendedNavigator.of(context).push(
                          Routes.loginScreen,
                          arguments: LoginScreenArguments(
                              userRepository: widget.userRepository),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: new TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
