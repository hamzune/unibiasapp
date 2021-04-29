import 'package:app/config/themes/light_theme.dart';
import 'package:app/constants/api_path.dart';
import 'package:app/core/auth/bloc/auth_bloc.dart';
import 'package:app/utils/models/user_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel _user = BlocProvider.of<AuthenticationBloc>(context).currentUser;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        backgroundColor: LightThemeColors.mainColor,
        title: Text(
          '  Settings',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          _user.pic != null
              ? CircleAvatar(
                  radius: 25.0,
                  backgroundImage:
                      NetworkImage("$apiUrl/images/profile/" + _user.pic),
                  backgroundColor: Colors.transparent,
                )
              : CircleAvatar(
                  radius: 25.0,
                  child: Text(
                    (_user.firstname[0] ?? '') + (_user.lastname[0] ?? ''),
                    style: TextStyle(color: LightThemeColors.mainColor),
                  ),
                  backgroundColor: LightThemeColors.background,
                ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        color: LightThemeColors.mainColor,
        // width: double.maxFinite,
        child: ListView(
          children: [
            // ListTile(
            //   leading: Icon(EvaIcons.person),
            //   title: Text('Accounts Settings'),
            //   trailing: Icon(EvaIcons.arrowForward),
            // ),
            // SizedBox(
            //   height: 40,
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(LightThemeColors.red),
                  ),
                  child: Text('Log Out'),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      LoggedOut(),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
