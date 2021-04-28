import 'dart:async';

import 'package:app/config/routing/modular_router.gr.dart';
import 'package:app/config/themes/light_theme.dart';
import 'package:app/modules/calendar/repositories/calendar_repository.dart';
import 'package:app/modules/calendar/screens/event_bottom_sheet.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;
  CalendarRepository calendarRepository;
  Future<List<dynamic>> _future;
  @override
  void initState() {
    _calendarController = CalendarController();
    calendarRepository = CalendarRepository();
    DateTime today = DateTime.now();

    DateTime start = DateTime(today.year, 3, 1, 0, 0, 0);
    DateTime end = DateTime(start.year + 1, start.month, start.day, 0, 0, 0);
    // _future = calendarRepository.getAPIEvents(start, end, false);
    _future = calendarRepository.getEventsLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        backgroundColor: LightThemeColors.mainColor,
      ),
      body: CupertinoScaffold(
        transitionBackgroundColor: LightThemeColors.mainColor,
        body: Container(
          decoration: BoxDecoration(
            // color: Color(0XFFf3f6f9),
            color: LightThemeColors.mainColor,
            borderRadius:
                BorderRadius.vertical(top: const Radius.circular(25.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            child: FutureBuilder(
              future: _future,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data != null) {
                  return SfCalendar(
                      controller: _calendarController,
                      allowedViews: [
                        CalendarView.week,
                        CalendarView.month,
                        CalendarView.schedule,
                      ],
                      showDatePickerButton: true,
                      allowViewNavigation: false,
                      view: CalendarView.week,
                      headerStyle: CalendarHeaderStyle(
                        // textAlign: TextAlign.justify,
                        backgroundColor: LightThemeColors.mainColor,
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 3,
                            fontWeight: FontWeight.w400),
                      ),
                      // showNavigationArrow: true,
                      monthViewSettings: MonthViewSettings(
                        showAgenda: true,
                        agendaViewHeight: 400,
                        monthCellStyle: MonthCellStyle(
                          leadingDatesBackgroundColor: Color(0XFFf3f6f9),
                          trailingDatesBackgroundColor: Color(0XFFf3f6f9),
                        ),
                      ),
                      firstDayOfWeek: 1,
                      showCurrentTimeIndicator: true,
                      todayHighlightColor: LightThemeColors.background,
                      backgroundColor: Colors.transparent,
                      dataSource: MeetingDataSource(snapshot.data),
                      headerHeight: 60,
                      headerDateFormat: '   MMMM',
                      timeSlotViewSettings: TimeSlotViewSettings(
                          timeFormat: 'H:mm',
                          timeIntervalHeight: 60,
                          startHour: 1,
                          endHour: 25),
                      // onLongPress: (CalendarLongPressDetails details) {
                      //   // DateTime date = details.date;
                      //   // CalendarElement view = details.targetElement;
                      //   CalendarView calendarView = _calendarController.view;
                      //   List<dynamic> appointments = details?.appointments;
                      //   if (appointments == null && calendarView == CalendarView.week) {
                      //     showAddEventScreen(context, null);
                      //   }
                      // },
                      onTap: (CalendarTapDetails details) {
                        DateTime date = details.date;
                        CalendarElement view = details.targetElement;
                        List<dynamic> appointments = details?.appointments;

                        try {
                          if (appointments.length > 0 &&
                              view == CalendarElement.appointment) {
                            if (appointments?.last == appointments?.first) {
                              // print(appointments?.first?.eventName);
                              showAddEventScreen(context, appointments?.first);
                            }
                          }
                        } catch (Error) {
                          if (_calendarController.view == CalendarView.week) {
                            if (date == selectedDate) {
                              selectedDate = null;

                              // Navigator.pushNamed(
                              //     context, Routes.appointmentScreen);
                            } else {
                              selectedDate = date;
                            }
                          }
                        }
                      });
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<dynamic> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}
