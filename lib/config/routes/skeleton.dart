import 'package:app/config/routing/modular_router.gr.dart';
import 'package:app/config/themes/light_theme.dart';
import 'package:app/modules/calendar/screens/appointment_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bottom_personalized_dot_bar/bottom_personalized_dot_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Sketeleton extends StatefulWidget {
  @override
  _SketeletonState createState() => _SketeletonState();
}

class _SketeletonState extends State<Sketeleton> {
  String _currentTab = "Dashboard";
  int _currentIndex = 0;
  List<int> order = [];
  List<String> pageKeys = ["Dashboard", "Calendar", "Profile"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Dashboard": GlobalKey<NavigatorState>(),
    "Calendar": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index, bool add) {
    if (tabItem == _currentTab) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = pageKeys[index];
        _currentIndex = index;
        if (add) {
          order.remove(index);
          order.add(index);
        }
      });
    }
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child:
          TabNavigator(navigatorkey: _navigatorKeys[tabItem], tabItem: tabItem),
    );
  }

  // BottomPersonalizedDotBar _customBottomNavigationBar() {
  //   return BottomPersonalizedDotBar(
  //     height: MediaQuery.of(context).padding.bottom + 60,
  //     bottomPadding: MediaQuery.of(context).padding.bottom + 10,
  //     // dotColor: Colors.transparent,
  //     borderRadius: BorderRadius.vertical(top: const Radius.circular(20.0)),
  //     keyItemSelected: _currentTab,
  //     doneText: 'Done',
  //     settingTitleText: 'Your Menu',
  //     settingSubTitleText: 'Drag and drop options',
  //     iconSettingColor: const Color(0xFFFFD201),
  //     buttonDoneColor: const Color(0xFFFFD500),
  //     settingSubTitleColor: const Color(0xFFFECE02),
  //     hiddenItems: <BottomPersonalizedDotBarItem>[
  //       BottomPersonalizedDotBarItem('item-9', icon: Icons.help, name: 'Ayuda',
  //           onTap: (itemSelected) {/* event selected */}),
  //     ],
  //     items: <BottomPersonalizedDotBarItem>[
  //       BottomPersonalizedDotBarItem('Dashboard',
  //           icon: EvaIcons.gridOutline, name: 'Flutter', onTap: (itemSelected) {
  //         _selectTab(itemSelected, 0, true);
  //       }),
  //       BottomPersonalizedDotBarItem('Calendar',
  //           icon: EvaIcons.calendarOutline,
  //           name: 'Favorito', onTap: (itemSelected) {
  //         _selectTab(itemSelected, 1, true);
  //       }),
  //       BottomPersonalizedDotBarItem('Profile',
  //           icon: Icons.face, name: 'Perfil', onTap: (itemSelected) {
  //         _selectTab(itemSelected, 2, true);
  //       }),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != "Dashboard") {
            if (order.length > 1) {
              int idx = order.removeLast();
              int idx2 = order.removeLast();
              _selectTab(pageKeys[idx2], idx2, false);
            } else {
              _selectTab("Dashboard", 0, false);
            }

            return false;
          }
        }

        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator("Dashboard"),
            _buildOffstageNavigator("Calendar"),
            _buildOffstageNavigator("Profile"),
            // _customBottomNavigationBar(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: FloatingActionButton(
            backgroundColor: LightThemeColors.orange,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AppointmentScreen()));
            },
            child: Icon(EvaIcons.plus),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: BottomAppBar(
            notchMargin: 8,
            child: Padding(
              padding: const EdgeInsets.only(right: 70, bottom: 4, top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    iconSize: 28,
                    icon: _currentIndex == 0
                        ? const Icon(
                            EvaIcons.pieChart2,
                            color: LightThemeColors.secondBlack,
                          )
                        : const Icon(
                            EvaIcons.pieChartOutline,
                            color: LightThemeColors.grey,
                          ),
                    onPressed: () {
                      _selectTab(pageKeys[0], 0, true);
                    },
                  ),
                  IconButton(
                    iconSize: 28,
                    icon: _currentIndex == 1
                        ? const Icon(
                            EvaIcons.calendar,
                            color: LightThemeColors.secondBlack,
                          )
                        : const Icon(
                            EvaIcons.calendarOutline,
                            color: LightThemeColors.grey,
                          ),
                    onPressed: () {
                      _selectTab(pageKeys[1], 1, true);
                    },
                  ),
                  IconButton(
                    iconSize: 28,
                    icon: _currentIndex == 2
                        ? const Icon(
                            EvaIcons.settings,
                            color: LightThemeColors.secondBlack,
                          )
                        : const Icon(
                            EvaIcons.settingsOutline,
                            color: LightThemeColors.grey,
                          ),
                    onPressed: () {
                      _selectTab(pageKeys[2], 2, true);
                    },
                  ),
                ],
              ),
            ),
            shape: CircularNotchedRectangle(),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorkey;
  final String tabItem;

  const TabNavigator({Key key, this.navigatorkey, this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String child;

    child = tabItem == "Dashboard"
        ? Routes.dashboardScreen
        : tabItem == "Calendar"
            ? Routes.calendarScreen
            : Routes.userProfileScreen;

    return Navigator(
      key: navigatorkey,
      onGenerateRoute: ModularRouter(),
      // onGenerateRoute: (routeSettings){
      //   return MaterialPageRoute(builder: (context)=> child)
      // },
      initialRoute: child,
    );
  }
}
