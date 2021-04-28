import 'package:app/config/routes/initial_screen.dart';
import 'package:app/config/themes/light_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/repositories/repositories.dart';

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // locale: const Locale('mn', 'MN'),
      home: InitialScreen(userRepository: userRepository),
      theme: _buildAppTheme(),
      // onGenerateRoute: ModularRouter(),
      // builder: ExtendedNavigator.builder(
      //   router: ModularRouter(),
      //   initialRoute: Routes.initialScreen,
      //   initialRouteArgs:
      //       InitialScreenArguments(userRepository: userRepository),
      //   builder: (_, extendedNav) => Theme(
      //     data: _buildAppTheme(),
      //     child: extendedNav,
      //   ),
      // ),
    );
  }

  ThemeData _buildAppTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: LightThemeColors.mainColor,
      accentColor: LightThemeColors.background,
      // scaffoldBackgroundColor: LightThemeColors.background,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: LightThemeColors.mainColor,
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme.light().copyWith(
          primary: LightThemeColors.background,
        ),
      ),
      appBarTheme: AppBarTheme(centerTitle: true, elevation: 0),
      textTheme: _buildAppTextTheme(base.textTheme),
      primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildAppTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(
        color: LightThemeColors.background,
      ),
    );
  }

  TextTheme _buildAppTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline6: base.headline6.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.background,
          ),
          headline5: base.headline5.copyWith(
              // fontSize: 14.0,
              // fontWeight: FontWeight.bold,
              // color: DarkThemeColors.background,
              ),
          headline1: base.headline1.copyWith(
              // fontSize: 14.0,
              // fontWeight: FontWeight.bold,
              // color: DarkThemeColors.background,
              ),
        )
        .apply(fontFamily: 'Lato');
  }
}
