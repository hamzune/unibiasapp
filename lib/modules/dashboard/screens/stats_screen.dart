import 'package:app/config/themes/dark_theme.dart';
import 'package:app/config/themes/light_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightThemeColors.mainColor,
        title: Text(
          'STATS',
          style: TextStyle(
              color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(EvaIcons.arrowBack),
          onPressed: () {
            // print(context.navigator.routerName);
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: Text('Stats'),
        ),
      ),
    );
  }
}
