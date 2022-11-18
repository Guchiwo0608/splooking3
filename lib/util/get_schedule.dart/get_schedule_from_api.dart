// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:splooking3/data/schedule.dart';

Future<ScheduleList> getScheduleList() async {
  final uri = Uri.parse('https://spla3.yuu26.com/api/schedule');
  final response = await http.get(uri);

  final _scheduleList = ScheduleList(
    openMatchScheduleList: [],
    regularMatchScheduleList: [],
    leagueMatchScheduleList: [],
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> schedules = jsonDecode(response.body)['result'];
    print(schedules.toString());
    _scheduleList
      ..openMatchScheduleList = schedules['bankara_open'].map(
        (schedule) {
          return Schedule.fromJson(schedule);
        },
      ).toList() as List<Schedule>
      ..regularMatchScheduleList = schedules['regular'].map(
        (schedule) {
          return Schedule.fromJson(schedule);
        },
      ).toList() as List<Schedule>
      ..leagueMatchScheduleList = schedules['league'].map(
        (schedule) {
          return Schedule.fromJson(schedule);
        },
      ).toList() as List<Schedule>;
  } else {
    throw Exception('Failed to load sentence');
  }

  return _scheduleList;
}
