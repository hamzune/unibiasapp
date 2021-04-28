import 'package:app/config/themes/light_theme.dart';
import 'package:app/modules/calendar/models/meeting.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

final DateFormat formatterdate = DateFormat('EEEE, MMMM d, y');
final DateFormat formatterhour = DateFormat('H:mm');

Widget _buildHandle(BuildContext context) {
  final theme = Theme.of(context);
  return FractionallySizedBox(
    widthFactor: 0.25,
    child: Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      child: Container(
        height: 5.0,
        decoration: BoxDecoration(
          color: theme.dividerColor,
          borderRadius: const BorderRadius.all(Radius.circular(2.5)),
        ),
      ),
    ),
  );
}

showAddEventScreen(dynamic context, Meeting event) {
  // print(event.toString());
  return showCupertinoModalBottomSheet(
    expand: true,
    topRadius: Radius.circular(20.0),
    context: context,
    enableDrag: true,
    builder: (context) => Material(
      child: Container(
        // top: false,
        child: Scaffold(
          backgroundColor: LightThemeColors.background,
          appBar: PreferredSize(
            child: Column(
              children: [
                _buildHandle(context),
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text(
                    'OverView',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            preferredSize: const Size.fromHeight(90),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 30,
            ),
            child: ListView(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event?.eventName,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(EvaIcons.clock, color: Colors.white60),
                    ),
                    title: Text(
                      formatterdate.format(event?.from),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      event.isAllDay
                          ? 'All Day'
                          : formatterhour.format(event?.from) +
                              ' - ' +
                              formatterhour.format(event?.to),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(Icons.meeting_room_rounded,
                          color: Colors.white60),
                    ),
                    title: Text(
                      'CLASSROOM',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(Icons.description, color: Colors.white60),
                    ),
                    title: Text(
                      'DESCRIPTION',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      'Sessions online',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Divider(
                      color: Colors.white38,
                      thickness: 0.8,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Attendess',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              FutureBuilder(
                  // future: ,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network('src'),
                        title: Text('Hamza'),
                      );
                    },
                  );
                } else {
                  return Text('');
                  // return CircularProgressIndicator();
                }
              })
            ]),
          ),
        ),
      ),
    ),
  );
}

addCustomEventScreen(dynamic context, dynamic event, bool expanded) {
  expand() {
    Navigator.of(context).pop();
    addCustomEventScreen(context, event, true);
  }

  return showCupertinoModalBottomSheet(
    expand: expanded,
    topRadius: Radius.circular(20.0),
    context: context,
    backgroundColor: Colors.transparent,
    enableDrag: true,
    builder: (context) => Material(
      child: SafeArea(
        top: false,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          // InkWell(
          //   onTap: () => expand(),
          //   child: FractionallySizedBox(
          //     widthFactor: 0.25,
          //     child: Container(
          //       margin: const EdgeInsets.symmetric(
          //         vertical: 12.0,
          //       ),
          //       child: Container(
          //         height: 5.0,
          //         decoration: BoxDecoration(
          //           color: Theme.of(context).dividerColor,
          //           borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          IconButton(
              iconSize: 50,
              color: Theme.of(context).dividerColor,
              icon: Icon(Icons.keyboard_arrow_up),
              onPressed: () => expand()),
          ListTile(
            title: Text('Expand'),
            leading: Icon(Icons.edit),
            onTap: () => {expand()},
          ),
          ListTile(
            title: Text('Copy'),
            leading: Icon(Icons.content_copy),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Copy'),
            leading: Icon(Icons.content_copy),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Copy'),
            leading: Icon(Icons.content_copy),
            onTap: () => Navigator.of(context).pop(),
          ),
        ]),
      ),
    ),
  );
}
