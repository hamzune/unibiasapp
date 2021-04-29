import 'package:app/_index.dart';
import 'package:app/constants/api_path.dart';
import 'package:app/modules/calendar/models/meeting.dart';
import 'package:app/utils/services/local_storage_service.dart';
import 'package:app/utils/services/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CalendarRepository {
  SecureLocalStorageService secureLocalStorageService;
  Dio restApiService;
  LocalStorageService localStorageService;

  CalendarRepository() {
    this.secureLocalStorageService = locator<SecureLocalStorageService>();
    this.localStorageService = locator<LocalStorageService>();
    this.restApiService = locator<Dio>();
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Future<List<dynamic>> getAttendes(String classId) async {
    var getAttendesUrl = '$apiUrl/entities/class/${classId.substring(5)}/users';
    Response response = await this.restApiService.get(getAttendesUrl);
    return response?.data;
  }

  Future<List<dynamic>> getAPIEvents(
      DateTime start, DateTime end, bool normal) async {
    var getEventsUrl = '$apiUrl/calendarevents';
    Response response = await this.restApiService.get(
      getEventsUrl,
      queryParameters: {
        'start': start.toIso8601String(),
        'end': end.toIso8601String()
      },
    );

    if (normal) return response?.data;
    return parseData(response?.data);
  }

  List<dynamic> parseData(dynamic data) {
    return data?.map((event) => mettingfromJSON(event))?.toList();
  }

  Meeting mettingfromJSON(dynamic json) {
    bool allday = json['allDay'] == 'true';
    return Meeting(
        json['id'],
        json['title'],
        DateTime.parse(json['start']).toLocal(),
        DateTime.parse(allday ? json['start'] : json['end']).toLocal(),
        fromHex(json['backgroundColor']),
        json['allDay'] == 'true',
        json['description'] ?? '',
        json['location'] ?? '',
        json['room'] ?? '');
  }

  Future<List<dynamic>> getEventsLocal() async {
    List<dynamic> events = await this.localStorageService.getObject('events');
    DateTime today = DateTime.now();

    if (events == null) {
      print('api');
      DateTime start = DateTime(today.year, 3, 1, 0, 0, 0);
      DateTime end = DateTime(start.year + 1, start.month, start.day, 0, 0, 0);

      List<dynamic> apiEvents = await this.getAPIEvents(start, end, true);

      // this.localStorageService.saveObject('events', apiEvents);

      return parseData(apiEvents);
    } else {
      print('local');
      DateTime yesterday =
          DateTime(today.year, today.month, today.day - 1, 0, 0, 0);

      DateTime inamonth =
          DateTime(yesterday.year, yesterday.month + 1, 1, 0, 0, 0);
      return this.updateLocalEvents(events, yesterday, inamonth);
      // return parseData(events);
    }
  }

  Future<List<dynamic>> updateLocalEvents(
      List<dynamic> events, DateTime start, DateTime end) async {
    List<dynamic> apiEvents = await this.getAPIEvents(start, end, true);

    for (int i = 0; i < events.length; i++) {
      if ((DateTime.parse(events[i]['start']).isAfter(start) &&
              DateTime.parse(events[i]['end']).isBefore(end)) ||
          DateTime.parse(events[i]['start']).isAtSameMomentAs(start)) {
        events.removeAt(i);
        i--;
      }
    }

    for (int i = 0; i < apiEvents.length; i++) {
      events.add(apiEvents[i]);
    }

    // this.localStorageService.saveObject('events', events);
    this.localStorageService.clearAll();
    return parseData(events);
  }

  bool containsList(List list, event) {
    bool contains = false;
    list.forEach((element) {
      if (element['id'] == event['id'] &&
          element['start'] == event['start'] &&
          element['room'] == event['room'] &&
          element['location'] == event['location'] &&
          element['description'] == event['description'] &&
          element['end'] == event['end'] &&
          element['title'] == event['title'] &&
          element['editable'] == event['editable'] &&
          element['backgroundColor'] == event['backgroundColor']) {
        contains = true;
      }
    });

    return contains;
  }
}
