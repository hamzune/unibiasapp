// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/auth/login/login_screen.dart';
import '../../modules/calendar/screens/appointment_screen.dart';
import '../../modules/calendar/screens/calendar_screen.dart';
import '../../modules/dashboard/screens/dashboard_screen.dart';
import '../../modules/dashboard/screens/stats_screen.dart';
import '../../modules/user_profile/screens/user_profile_screen.dart';
import '../../repositories/repositories.dart';
import '../../utils/models/user_model.dart';
import '../routes/initial_screen.dart';

class Routes {
  static const String initialScreen = '/initial-screen';
  static const String loginScreen = '/login-screen';
  static const String dashboardScreen = '/dashboard-screen';
  static const String statsScreen = '/stats-screen';
  static const String calendarScreen = '/calendar-screen';
  static const String appointmentScreen = '/appointment-screen';
  static const String userProfileScreen = '/user-profile-screen';
  static const all = <String>{
    initialScreen,
    loginScreen,
    dashboardScreen,
    statsScreen,
    calendarScreen,
    appointmentScreen,
    userProfileScreen,
  };
}

class ModularRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.initialScreen, page: InitialScreen),
    RouteDef(Routes.loginScreen, page: LoginScreen),
    RouteDef(Routes.dashboardScreen, page: DashboardScreen),
    RouteDef(Routes.statsScreen, page: StatsScreen),
    RouteDef(Routes.calendarScreen, page: CalendarScreen),
    RouteDef(Routes.appointmentScreen, page: AppointmentScreen),
    RouteDef(Routes.userProfileScreen, page: UserProfileScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    InitialScreen: (data) {
      final args = data.getArgs<InitialScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => InitialScreen(
          key: args.key,
          userRepository: args.userRepository,
        ),
        settings: data,
      );
    },
    LoginScreen: (data) {
      final args = data.getArgs<LoginScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginScreen(
          key: args.key,
          userRepository: args.userRepository,
          onRegisterClicked: () {},
        ),
        settings: data,
      );
    },
    DashboardScreen: (data) {
      final args = data.getArgs<DashboardScreenArguments>(
        orElse: () => DashboardScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => DashboardScreen(
          key: args.key,
          user: args.user,
        ),
        settings: data,
      );
    },
    StatsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StatsScreen(),
        settings: data,
      );
    },
    CalendarScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CalendarScreen(),
        settings: data,
      );
    },
    AppointmentScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AppointmentScreen(),
        settings: data,
      );
    },
    UserProfileScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserProfileScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// InitialScreen arguments holder class
class InitialScreenArguments {
  final Key key;
  final UserRepository userRepository;
  InitialScreenArguments({this.key, @required this.userRepository});
}

/// LoginScreen arguments holder class
class LoginScreenArguments {
  final Key key;
  final UserRepository userRepository;
  LoginScreenArguments({this.key, @required this.userRepository});
}

/// DashboardScreen arguments holder class
class DashboardScreenArguments {
  final Key key;
  final UserModel user;
  DashboardScreenArguments({this.key, this.user});
}
