import 'package:app/config/themes/light_theme.dart';
import 'package:app/constants/api_path.dart';
import 'package:app/modules/calendar/models/meeting.dart';
import 'package:app/modules/calendar/repositories/calendar_repository.dart';
import 'package:app/utils/models/user_model.dart';
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

showAddEventScreen(
    dynamic context, Meeting event, CalendarRepository calendarrepo) {
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
                  event.room != ''
                      ? ListTile(
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
                            event.room,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  event.description != '' && event.description != ''
                      ? ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child:
                                Icon(Icons.description, color: Colors.white60),
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
                            event.description,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  event.location != ''
                      ? ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Icon(Icons.location_city,
                                color: Colors.white60),
                          ),
                          title: Text(
                            'LOCATION',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            event.location,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
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
              event.eventId[0] == 'c'
                  ? Text(
                      'Attendess',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 20,
              ),
              event.eventId[0] == 'c'
                  ? FutureBuilder(
                      future: calendarrepo.getAttendes(event.eventId),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.data != null) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: snapshot.data[index]['pic'] != null
                                    ? CircleAvatar(
                                        radius: 22.0,
                                        backgroundImage: NetworkImage(
                                            "$apiUrl/images/profile/" +
                                                snapshot.data[index]['pic']),
                                        backgroundColor: Colors.transparent,
                                      )
                                    : CircleAvatar(
                                        radius: 22.0,
                                        child: Text(
                                          snapshot.data[index]['fullname'][0]
                                                  .toUpperCase() ??
                                              '',
                                          style: TextStyle(
                                              color:
                                                  LightThemeColors.mainColor),
                                        ),
                                        backgroundColor: event.background,
                                      ),
                                title: Text(
                                  snapshot.data[index]['fullname'],
                                  style: TextStyle(
                                      color: LightThemeColors.mainColor),
                                ),
                              );
                              // return Text('');
                            },
                          );
                        } else {
                          return const Center(
                            heightFactor: 200,
                            child: CircularProgressIndicator(
                              backgroundColor: LightThemeColors.mainColor,
                            ),
                          );
                          // return CircularProgressIndicator();
                        }
                      })
                  : SizedBox.shrink(),
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
