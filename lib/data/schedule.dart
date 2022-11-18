class Schedule {
  Schedule({
    required this.startTime,
    required this.endTime,
    required this.rule,
    required this.stages,
    required this.matchType,
    required this.isFest,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    final stages = (json['stages'] as List<Map<String, String>>).map((e) {
      return {
        'name': e['name']!,
        'image': e['image']!,
      };
    }).toList();
    return Schedule(
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      rule: Map<String, dynamic>.from(json['rule'])['name'],
      stages: stages,
      matchType: '',
      isFest: json['is_fest'] == 'true',
    );
  }
  DateTime startTime;
  DateTime endTime;
  String rule;
  List<Map<String, String>> stages;
  String matchType;
  bool isFest;
}

class ScheduleList {
  ScheduleList({
    required this.openMatchScheduleList,
    required this.regularMatchScheduleList,
    required this.leagueMatchScheduleList,
  });

  factory ScheduleList.fromJson(Map<String, dynamic> json) {
    return ScheduleList(
      openMatchScheduleList: (json['bankara_open'] as List).map(
        (schedule) {
          return Schedule.fromJson(schedule);
        },
      ).toList(),
      regularMatchScheduleList: (json['regular'] as List).map(
        (schedule) {
          return Schedule.fromJson(schedule);
        },
      ).toList(),
      leagueMatchScheduleList: (json['league'] as List).map(
        (schedule) {
          return Schedule.fromJson(schedule);
        },
      ).toList(),
    );
  }
  List<Schedule> openMatchScheduleList;
  List<Schedule> regularMatchScheduleList;
  List<Schedule> leagueMatchScheduleList;
}
