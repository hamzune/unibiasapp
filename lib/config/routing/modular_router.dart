import 'package:app/config/routes/initial_screen.dart';
import 'package:app/core/auth/login/login_screen.dart';
import 'package:app/modules/calendar/screens/appointment_screen.dart';
import 'package:app/modules/calendar/screens/calendar_screen.dart';
import 'package:app/modules/dashboard/screens/dashboard_screen.dart';
import 'package:app/modules/dashboard/screens/stats_screen.dart';
import 'package:app/modules/user_profile/screens/user_profile_screen.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: InitialScreen),
    MaterialRoute(page: LoginScreen),
    // MaterialRoute(
    //     page: DashboardScreen, children: [AutoRoute(page: StatsScreen)]),
    MaterialRoute(page: DashboardScreen),
    MaterialRoute(page: StatsScreen),

    MaterialRoute(page: CalendarScreen),
    MaterialRoute(page: AppointmentScreen),

    MaterialRoute(page: UserProfileScreen),
  ],
)
class $ModularRouter {}

// flutter pub run build_runner watch --delete-conflicting-outputs
