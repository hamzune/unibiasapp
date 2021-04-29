import 'dart:convert';

import 'package:app/_index.dart';
import 'package:app/config/themes/light_theme.dart';
import 'package:app/constants/api_path.dart';
import 'package:app/utils/services/local_storage_service.dart';
import 'package:app/utils/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DashboardRepository {
  SecureLocalStorageService secureLocalStorageService;
  Dio restApiService;
  LocalStorageService localStorageService;
  final String dashboardUrl = '$apiUrl/dashboard';
  final universities = ['upf', 'unk'];

  DashboardRepository() {
    this.secureLocalStorageService = locator<SecureLocalStorageService>();
    this.localStorageService = locator<LocalStorageService>();
    this.restApiService = locator<Dio>();
  }

  Future<List<ChartData>> getUniversitiesStats() async {
    List<ChartData> output = [];
    Response response =
        await this.restApiService.get(dashboardUrl + '/stats/universities');
    for (int i = 0; i < response.data.length; i++) {
      output.add(ChartData(this.universities[response.data[i]['id_university']],
          response.data[i]['amount']));
    }
    return output;
  }

  Future<dynamic> getWeekData() async {
    // Future<List<ChartData>> getWeekData() async {
    List<ChartData> output = [];
    int todayweek = DateTime.now().weekday - 1;
    List<String> days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    double totalHours = 0;
    int totalClasses = 0;
    Response response = await this.restApiService.get(dashboardUrl + '/stats');
    int d = 0;

    for (int i = 0; i < response.data.length; i++) {
      if (d == response.data[i]['dayName']) {
        output.add(ChartData(days[d], response.data[i]['classes'],
            todayweek == d ? LightThemeColors.orange : Color(0xffc5dfec)));
        totalHours += response.data[i]['amount_of_hours'];
        totalClasses += response.data[i]['classes'];
      } else {
        output.add(ChartData(days[d], 0,
            todayweek == d ? LightThemeColors.orange : Color(0xffc5dfec)));
        --i;
      }
      d++;
    }

    return [output, totalHours, totalClasses];
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color color;
}
